//
//  DataProcessor.swift
//  car
//
//  Created by Sara Nordberg on 12/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

extension ArraySlice where Iterator.Element == UInt8 {
    var pid: String {
        let range = startIndex..<startIndex.advanced(by: 3)
        return String(bytes: self[range], encoding: .ascii)!
    }
}

struct DataProcessor {
    
    static var separator: UInt8 = 13 // 13 is '\r' in hex
    
    func process(_ data: [UInt8]) -> CanMessageCollection {
        
        var collection = CanMessageCollection()
        
        for line in data.split(separator: DataProcessor.separator) {
            
            guard line.count > 16 else { continue }
            
            guard let pid = PID(rawValue: line.pid) else {
                if line.pid != "\0\0\0" {
                    print(TextMessage(data: line).description)
                }
                continue
            }
            
            let canMessage: CanMessage
            
            switch pid {
            case .odometer:
                canMessage = OdometerMessage(data: line)
            case .chargeLevel:
                canMessage = BatteryLevelMessage(data: line)
            }
            
            collection.add(data: canMessage, for: pid)
        }
        
        return collection
    }
    
    func supports(_ data: [UInt8]) -> Bool {
        if let line = data.split(separator: DataProcessor.separator).first, line.count > 16 {
            return PID(rawValue: line.pid) != nil
        }
        return false
    }
}
