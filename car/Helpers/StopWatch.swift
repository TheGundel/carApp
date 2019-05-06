//
//  StopWatch.swift
//  car
//
//  Created by Sara Nordberg on 03/04/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation

class StopWatch {
    
    private var startTime: NSDate?
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        }
        else {
            return 0
        }
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
}
