//
//  Connect.swift
//  car
//
//  Created by Sara Nordberg on 08/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

enum CommandError: Error {
    case isBusy
    case outputStreamIsNotConnected
}

class Connect: NSObject {
    
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    
    private var socket: SocketProtocol
    
    private var host: String
    private var currentPID: PID
    private var commandsQueue = [ATCommandProtocol]()
    private var dataProcessor = DataProcessor()
    
    weak var delegate: ConnectDelegate?
    
    private var last: ATCommandProtocol?
    
    var isConnected: Bool {
        return inputStream?.streamStatus == .open || outputStream?.streamStatus == .open
    }
    
    var pid: PID {
        return currentPID
    }
    
    var lastCommand: ATCommandProtocol? { return last }
    
    
    typealias SocketInitializer = (CFString, UInt32) -> SocketProtocol
    
    init(observing pid: PID = .odometer, socketInitializer: SocketInitializer = SocketFactory.createSocket, host: CFString = "192.168.0.10" as CFString, port: UInt32 = 35000) {
        self.currentPID = pid
        self.socket = socketInitializer(host, port)
        self.host = host as String
        
    }
    
    public func connect() {
        guard !isConnected else { return }
        
        socket.open()
        
        inputStream = socket.inputStream
        outputStream = socket.outputStream
        
        ([inputStream, outputStream] as [Stream]).forEach {
            $0.delegate = self
            $0.schedule(in: .current, forMode: RunLoop.Mode.common)
            $0.open()
        }
    }
    
    public func disconnect() {
        guard inputStream.streamStatus != .closed, outputStream.streamStatus != .closed else { return }
        send(command: AdHocCommand.stopRead)
        inputStream.close()
        outputStream.close()
        
        delegate?.connect(self, didDisconnectFromHost: host)
        
        last = nil
    }
    
    public func getPID() -> PID{
        return currentPID
    }
    
    
    public func send(command: ATCommandProtocol) {
        
        guard outputStream?.streamStatus != .writing else {
            delegate?.connect(self, failedToSendCommand: command, dueToErrorOfKind: .isBusy)
            return
        }
        
        guard outputStream?.streamStatus == .open else {
            delegate?.connect(self, failedToSendCommand: command, dueToErrorOfKind: .outputStreamIsNotConnected)
            return
        }
        
        switch command {
        case ConfigurationCommand.setPID(let pid):
            currentPID = pid
            if commandsQueue.isEmpty {
                commandsQueue = [
                    ConfigurationCommand.setPID(pid),
                    AdHocCommand.read]
                handleQueue()
                return
            }
            
        case let initiate as AdHocCommand where initiate == AdHocCommand.initiate:
            runSetup()
            return
        default:
            break
        }
        
        print("Sending command: \(command.description)")
        last = command
        let data = command.data
        _ = data.withUnsafeBytes { outputStream.write($0, maxLength: data.count) }
    }
    
    func changePID(){
        if(!commandsQueue.isEmpty){
            return
        }
        
        send(command: AdHocCommand.stopRead)
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            if(self.currentPID == .chargeLevel){
                self.commandsQueue = [ConfigurationCommand.setPID(.odometer), AdHocCommand.read]
                
            } else {
                self.commandsQueue = [ConfigurationCommand.setPID(.chargeLevel), AdHocCommand.read]
            }
            self.handleQueue()
        }
    }
    
    private func runSetup() {
        commandsQueue = [ConfigurationCommand.reset,
                         ConfigurationCommand.selectISO,
                         ConfigurationCommand.eccoOfPage10,
                         ConfigurationCommand.setHeader(true),
                         ConfigurationCommand.automaticFormatting(false),
                         ConfigurationCommand.setSpaces(false),
                         ConfigurationCommand.setPID(currentPID),
                         AdHocCommand.read]
        handleQueue()
    }
    
    private func handleQueue() {
        if let command = commandsQueue.first {
            commandsQueue.remove(at: 0)
            send(command: command)
        }
    }
}

extension Connect: StreamDelegate {
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .openCompleted:
            delegate?.connect(self, didConnectToHost: host)
        case .hasBytesAvailable:
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            delegate?.connectDidReceiveEndEncountered(self)
        case .errorOccurred:
            delegate?.connect(self, failedToConnectToHost: host, withError: aStream.streamError)
        default:
            break
        }
    }
    
    /**
     Utility function for reading the bytes from the stream.
     
     - Parameters:
     - stream: The stream from which the bytes should be read.
     */
    private func readAvailableBytes(stream: InputStream) {
        
        typealias Byte = UInt8
        var buffer: [Byte]
        
        // Allocating space depending on the type of command sent last
        if last is ConfigurationCommandProtocol {
            buffer = [Byte](repeating: 0, count: 1 << 10)
        } else {
            buffer = [Byte](repeating: 0, count: 1 << 8)
        }
        
        // Looping through the bytes of the input stream
        while stream.hasBytesAvailable {
            
            // Reading from the stream
            let numberOfBytesRead = inputStream.read(&buffer, maxLength: buffer.count)
            
            // Handle a read error
            if numberOfBytesRead < 0, let error = stream.streamError {
                delegate?.connect(self, didEncounterReadError: error)
                break
            }
            
            // Decode the configuration response
            if lastCommand is ConfigurationCommandProtocol, !dataProcessor.supports(buffer) {
                let response = (String(bytes: buffer, encoding: .ascii)) ?? "Unable to decode response"
                print("Response: \(response)")
                
                // Postponing the next action, in order not to flood the hardware
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                    self.handleQueue()
                }
                
                return
            }
            
            delegate?.connect(self, didReceiveDataCollection: dataProcessor.process(buffer))
        }
    }
}

fileprivate struct Socket: SocketProtocol {
    
    let host: CFString
    let port: UInt32
    
    private var readStream: Unmanaged<CFReadStream>?
    private var writeStream: Unmanaged<CFWriteStream>?
    
    var inputStream: InputStream {
        return readStream!.takeRetainedValue() as InputStream
    }
    
    var outputStream: OutputStream {
        return writeStream!.takeRetainedValue() as OutputStream
    }
    
    init(host: CFString = "192.168.0.10" as CFString, port: UInt32 = 35000) {
        self.host = host
        self.port = port
    }
    
    mutating func open() {
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host as CFString, port, &readStream, &writeStream)
    }
}

fileprivate struct SocketFactory {
    static func createSocket(host: CFString, port: UInt32) -> SocketProtocol {
        return Socket(host: host, port: port)
    }
}
