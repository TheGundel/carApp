//
//  CanMessage.swift
//  car
//
//  Created by Sara Nordberg on 12/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

protocol CanMessage: CustomStringConvertible, Codable {
    init(data: [UInt8])
}

extension CanMessage {
    init(data: ArraySlice<UInt8>) {
        self.init(data: Array(data))
    }
}

enum PID: String, Codable {
    case odometer = "412"
    case chargeLevel = "2D5"
    
    var identifier: String {
        switch self {
        case .chargeLevel: return "Battery Level"
        case .odometer: return "Odometer"
        }
    }
}

struct OdometerMessage: CanMessage {
    
    /// The velocity in km/h
    let velocity: Int
    
    /// The milage in km
    let milage: Int
    
    init(data: [UInt8]) {
        velocity = hexInt(from: data[5..<7])
        milage = hexInt(from: data[7..<13])
    }
    
    var description: String {
        return """
        Velocity: \(velocity)
        Milage: \(milage)
        """
    }
}

struct BatteryLevelMessage: CanMessage {
    
    let level: Double
    
    init(data: [UInt8]) {
        level = hexDouble(from: data[12..<15]) / 10
    }
    
    var description: String {
        return "Battery level \(level)%"
    }
}

struct TextMessage: CanMessage {
    
    private let message: String
    
    init(data: [UInt8]) {
        message = String(bytes: data, encoding: .ascii)!
    }
    
    var description: String {
        return message
    }
}

struct CanMessageCollection: Codable {
    
    public let date: Date
    private var data = [String: [CanMessage]]()
    
    mutating func add(data: CanMessage, for pid: PID) {
        if let currentData = self.data[pid.identifier] {
            self.data[pid.identifier] = currentData + [data]
        } else {
            self.data[pid.identifier] = [data]
        }
    }
    
    func data(for pid: PID) -> [CanMessage]? {
        return data[pid.identifier]
    }
    
    mutating func addingContentsOf(other: CanMessageCollection) {
        data = data.merging(other.data) { $0 + $1 }
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case chargeLevel = "Battery Level"
        case odometer = "Odometer"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encodeIfPresent(data(for: .chargeLevel) as? [BatteryLevelMessage], forKey: .chargeLevel)
        try container.encodeIfPresent(data(for: .odometer) as? [OdometerMessage], forKey: .odometer)
    }
    
    init() {
        date = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        data[PID.chargeLevel.identifier] = try container.decodeIfPresent([BatteryLevelMessage].self, forKey: .chargeLevel)
        data[PID.odometer.identifier] = try container.decodeIfPresent([OdometerMessage].self, forKey: .odometer)
    }
}

extension CanMessageCollection: Equatable {
    static func ==(lhs: CanMessageCollection, rhs: CanMessageCollection) -> Bool {
        return ![PID.chargeLevel, .odometer].map({
            lhs.data(for: $0)?.count == rhs.data(for: $0)?.count
        }).contains(false) && lhs.date == rhs.date
    }
}


private enum Bit: UInt8, CustomStringConvertible {
    case zero, one
    
    var description: String {
        switch self {
        case .one:
            return "1"
        case .zero:
            return "0"
        }
    }
}

private func bits(fromByte byte: UInt8) -> [Bit] {
    var byte = byte
    return (0..<8).map { _ in
        let currentBit = byte & 0x01
        if currentBit != 0 {
            return .one
        }
        byte >>= 1
        return .zero
    }
}

private func hexInt<S>(from bytes: S) -> Int where S : Sequence, S.Element == UInt8 {
    return Int(String(bytes: bytes, encoding: .ascii)!, radix: 16)!
}

private func hexDouble<S>(from bytes: S) -> Double where S : Sequence, S.Element == UInt8 {
    return Double(hexInt(from: bytes))
}
