//
//  Commands.swift
//  car
//
//  Created by Sara Nordberg on 12/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

protocol Command {
    
    /**
     The AT Command as a String
     */
    var message: String { get }
    
    /**
     The ASCII formatted data of the AT Command
     */
    var data: Data { get }
}

typealias ATCommandProtocol = Command & CustomStringConvertible

extension Command {
    var data: Data {
        return message.data(using: .ascii)!
    }
}

extension CustomStringConvertible where Self: Command {
    var description: String {
        return message
    }
}

protocol ConfigurationCommandProtocol: ATCommandProtocol {}

enum ConfigurationCommand: ConfigurationCommandProtocol, Equatable {
    
    /**
     An AT reset command (AT Z)
     */
    case reset
    
    /**
     Select the Can protocol ISO 15765-4 11/500
     */
    case selectISO
    
    /**
     ecco off page 10
     */
    case eccoOfPage10
    
    /**
     Set header on/off
     */
    case setHeader(Bool)
    
    /**
     Set PID
     */
    case setPID(PID)
    
    /**
     Set automatic formatting
     */
    case automaticFormatting(Bool)
    
    /**
     Set spaces on/off
     */
    case setSpaces(Bool)
    
    var message: String {
        switch self {
        case .reset:
            return "ATZ\r"
        case .selectISO:
            return "ATSP6\r"
        case .eccoOfPage10:
            return "ATE0\r"
        case .setHeader(let on):
            return "ATH\(on ? 1 : 0)\r"
        case .setPID(let pid):
            return "ATCRA\(pid.rawValue)\r"
        case .automaticFormatting(let on):
            return "ATCAF\(on ? 1 : 0)\r"
        case .setSpaces(let on):
            return "ATS\(on ? 1 : 0)\r"
        }
    }
    
    static func ==(lhs: ConfigurationCommand, rhs: ConfigurationCommand) -> Bool {
        return lhs.message == rhs.message
    }
}

/**
 Data structure for representing AT Commands
 */

struct AdHocCommand: ATCommandProtocol, Equatable {
    
    let message: String
    
    static var read: AdHocCommand {
        return AdHocCommand(message: "ATMA\r")
    }
    
    static var stopRead: AdHocCommand {
        return AdHocCommand(message: "e\r")
    }
    
    static var initiate: AdHocCommand {
        return AdHocCommand(message: "BOOT")
    }
    
    private init(message: String) {
        self.message = message
    }
    
    static func ==(lhs: AdHocCommand, rhs: AdHocCommand) -> Bool {
        return lhs.message == rhs.message
    }
}
