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
    
    case brakeLevel = "208"
    //case lightStatus = "424" // 423? TODO?
    case ac = "3A4" // TODO?
    case shift = "418" // Gear
    case odometer = "412"
    //Try and use 2D5 - Brug D4 & D5 : Udregnes ved D4+D5(hex -> omregn til decimal) / 10
    //518 kan være eco % ? 
    case chargeLevel = "2D5"
    case powerUsage = "346"
    //case wheelPosition = "0C2" // "236" TODO?
    
    var identifier: String {
        switch self {
        case .brakeLevel: return "Brake Level"
        case .ac: return "A/C"
        case .chargeLevel: return "Battery Level"
        case .shift: return "Shift"
        case .odometer: return "Odometer"
        case .powerUsage: return "Power Usage"
        }
    }
    
}

struct BrakeMessage: CanMessage {
    
    let level: Double
    
    init(data: [UInt8]) {
        
        let current = hexDouble(from: data[7..<11])
        let ref = Double(0x6000)
        let max = Double(0x1B0)
        
        self.level = (current - ref) / max
    }
    
    var description: String {
        return String(format: "Brake level: %.2f", level * 100) + "% downpressed"
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

struct ACMessage: CanMessage {
    
    let isOn: Bool
    let blowLevel: Int
    let temperatureStep: Int
    
    var isHeating: Bool {
        return temperatureStep > 7
    }
    
    var isCooling: Bool {
        return temperatureStep < 7
    }
    
    init(data: [UInt8]) {
        isOn = Data(bytes: data[3..<4]) == "8".data(using: .ascii)!
        blowLevel = hexInt(from: data[6..<7])
        temperatureStep = hexInt(from: data[4..<5])
    }
    
    var description: String {
        return """
        isOn: \(isOn)
        Level: \(blowLevel)
        Temperaturestep: \(temperatureStep)
        """
    }
    
}

struct ShiftMessage: CanMessage {
    
    enum ShiftStatus: String, Codable {
        case parking = "50"
        case reverse = "52"
        case n = "4E"
        case drive = "44"
        case e = "83"
        case b = "32"
        case unknown = "FF"
    }
    
    let gear: ShiftStatus
    
    init(data: [UInt8]) {
        gear = ShiftStatus(rawValue: String(bytes: data[3...4], encoding: .ascii)!) ?? .unknown
    }
    
    var description: String {
        return "Gear: \(gear)"
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

struct LightStatusMessage: CanMessage {
    
    let isHeadlineOn: Bool
    let isFlashingLeft: Bool
    let isFlashingRight: Bool
    
    init(data: [UInt8]) {
        
        //let bits = bits(fromByte: data.)
        isHeadlineOn = true
        isFlashingLeft = true
        isFlashingRight = true
    }
    
    var description: String {
        return ""
    }
    
}

struct PowerUsageMessage: CanMessage {
    
    typealias Watts = Int
    let usage: Watts
    
    init(data: [UInt8]) {
        usage = (hexInt(from: data[3..<7]) - 10_000) * 10
    }
    
    var description: String {
        return "Usage: \(usage)W"
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

struct SteeringWheelMessage: CanMessage {
    
    typealias Degree = Double
    
    /// Negative angle: right
    /// Positive angle: left
    let rotation: Degree
    
    init(data: [UInt8]) {
        self.rotation = (hexDouble(from: data[3..<7]) - Double(1 << 12)) / 2.0
    }
    
    var description: String {
        return "Rotation: \(rotation)"
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
        case brakeLevel = "Brake Level"
        case ac = "A/C"
        case chargeLevel = "Battery Level"
        case shift = "Shift"
        case odometer = "Odometer"
        case powerUsage = "Power Usage"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encodeIfPresent(data(for: .ac) as? [ACMessage], forKey: .ac)
        try container.encodeIfPresent(data(for: .brakeLevel) as? [BrakeMessage], forKey: .brakeLevel)
        try container.encodeIfPresent(data(for: .chargeLevel) as? [BatteryLevelMessage], forKey: .chargeLevel)
        try container.encodeIfPresent(data(for: .shift) as? [ShiftMessage], forKey: .shift)
        try container.encodeIfPresent(data(for: .odometer) as? [OdometerMessage], forKey: .odometer)
        try container.encodeIfPresent(data(for: .powerUsage) as? [PowerUsageMessage], forKey: .powerUsage)
    }
    
    init() {
        date = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        data[PID.ac.identifier] = try container.decodeIfPresent([ACMessage].self, forKey: .ac)
        data[PID.brakeLevel.identifier] = try container.decodeIfPresent([BrakeMessage].self, forKey: .brakeLevel)
        data[PID.chargeLevel.identifier] = try container.decodeIfPresent([BatteryLevelMessage].self, forKey: .chargeLevel)
        data[PID.shift.identifier] = try container.decodeIfPresent([ShiftMessage].self, forKey: .shift)
        data[PID.odometer.identifier] = try container.decodeIfPresent([OdometerMessage].self, forKey: .odometer)
        data[PID.powerUsage.identifier] = try container.decodeIfPresent([PowerUsageMessage].self, forKey: .powerUsage)
    }
    
}

extension CanMessageCollection: Equatable {
    static func ==(lhs: CanMessageCollection, rhs: CanMessageCollection) -> Bool {
        return ![PID.brakeLevel, .ac, .chargeLevel, .shift, .odometer, .powerUsage].map({
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
