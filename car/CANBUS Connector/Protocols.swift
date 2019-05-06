//
//  Protocols.swift
//  car
//
//  Created by Sara Nordberg on 13/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

protocol SocketProtocol {
    var inputStream: InputStream { get }
    var outputStream: OutputStream { get }
    
    var host: CFString { get }
    var port: UInt32 { get }
    
    init(host: CFString, port: UInt32)
    
    mutating func open()
}

protocol ConnectDelegate: class {
    
    //Failed to connect to host
    func connect(_ connection: Connect, failedToConnectToHost host: String, withError error: Error?)
    
    //Successful connection to host
    func connect(_ connection: Connect, didConnectToHost host: String)
    
    //Received data from the input stream
    func connect(_ connection: Connect, didReceiveDataCollection dataCollection: CanMessageCollection)
    
    //AT Command failed to send
    func connect(_ connection: Connect, failedToSendCommand command: ATCommandProtocol, dueToErrorOfKind kind: CommandError)
    
    //Read error
    func connect(_ connection: Connect, didEncounterReadError error: Error)
    
    //Received encountered event from stream
    func connectDidReceiveEndEncountered(_ connection: Connect)
    
    //Disconnect the host
    func connect(_ connection: Connect, didDisconnectFromHost host: String)
}
