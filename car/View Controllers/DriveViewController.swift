//
//  DriveViewController.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import UIKit

class DriveViewController: UIViewController, ConnectDelegate {

   let watch = StopWatch()
    
    private var connection: Connect!
    var driveView = DriveView()
    
    override func loadView() {
        view = driveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connection = Connect()
        connection.delegate = self
        
        driveView.connectButton.addTarget(self, action: #selector(connect(sender:)), for: .touchUpInside)
        driveView.disconnectButton.addTarget(self, action: #selector(disconnect(sender:)), for: .touchUpInside)
    }
    
    var running = false
    var timer: Timer?
    var time: TimeInterval = 5.0
    
    //Change PID between odometer and battery
    func PIDChange() {
        if(running && connection.isConnected){
            if(timer == nil){
                timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true) { _ in
                    if(!self.connection.isConnected){
                        if(self.timer != nil){
                            self.timer!.invalidate()
                            self.timer = nil
                        }
                    } else {
                        self.connection.changePID()
                        self.time = self.connection.getPID() == .odometer ? 1.0 : 5.0
                        self.timer!.invalidate()
                        self.timer = nil
                        self.PIDChange()
                    }
                }
            }
        }
        if(running == false){
            running = true
        }
    }
    
    @objc func connect(sender: UIButton!) {
        print("Trying to connect")
        driveView.startLabel.text = "Trying to connect to OBD II..."
        if connection.isConnected {
            connection.disconnect()
        } else {
            connection.connect()
        }
    }
    
    @objc func disconnect(sender: UIButton!) {
        print("Trying to disconnect")
        driveView.startLabel.text = "Disconnecting..."
        if connection.isConnected {
            connection.disconnect()
        }
        watch.stop()
        
        // Calculate the battery usage
        let subS = String(driveView.batteryLifeResult.text!.dropLast(2))
        let endBat = Double(subS)
        let batteryUsage = startBat - endBat!
        let batteryUsageRounded = (batteryUsage*100).rounded() / 100
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Deletes old core data before adding new data
        do {
            var summary: [Summary] = []
            summary = try context.fetch(Summary.fetchRequest())
            if(summary.count > 0){
                for sum in summary{
                    context.delete(sum)
                }
            }
        } catch {
            print("Fetching Failed")
        }
        
        let sum = Summary(context: context) // Link Summary & Context
        
        //Add data results
        sum.distance = driveView.mapResult.text
        sum.battery = driveView.batteryLifeResult.text
        sum.time = driveView.timeResult.text
        sum.batteryUsage = batteryUsageRounded
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        //Push new viewController
        let vc = SumViewController()
        present(vc, animated: false, completion: nil)
    }
    
    //Update stop watch
    @objc func updateElapsedTimeLabel(timer : Timer) {
        if watch.isRunning {
            let minutes = Int(watch.elapsedTime / 60)
            let seconds = Int(watch.elapsedTime)%60
            let tenOfSeconds = Int(watch.elapsedTime * 10) % 10
            driveView.timeResult.text = String(format: "%02d:%02d.%d", minutes, seconds, tenOfSeconds)
        }
        else {
            timer.invalidate()
        }
    }
    
    func connect(_ connection: Connect, failedToConnectToHost host: String, withError error: Error?) {
        print("Failed to connect to \(host) reason: \(error?.localizedDescription ?? "")")
        
        //Alert message
        let alert = UIAlertController(title: "Failed to Connect", message: "Failed to connect to OBD, please check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        //Reset info label
        driveView.startLabel.text = "Start collecting data"
    }
    
    func connect(_ connection: Connect, didConnectToHost host: String) {
        print("Connected to \(host)")
        
        //Perform setup for receiving data
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            connection.send(command: AdHocCommand.initiate)
        }
        //Change PID after initial setup connection
        PIDChange()
        
        //Change button to disconnect button
        driveView.startLabel.text = "Stop collecting data"
        driveView.connectButton.isHidden = true
        driveView.disconnectButton.isHidden = false
    }
    
    var startMilage = Measurement(value: 0, unit: UnitLength.kilometers)
    var startBat = Double()
    private let formatter = MeasurementFormatter()
    
    func connect(_ connection: Connect, didReceiveDataCollection dataCollection: CanMessageCollection) {
        if(!watch.isRunning){
            watch.start()
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
        }
        print("Received Data:", dataCollection)
        
        guard let data = dataCollection.data(for: connection.pid) else { return }
        if let message = (data as? [OdometerMessage])?.last {
            driveView.speedResult.text = {
                let velocity = Measurement(value: Double(message.velocity), unit: UnitSpeed.kilometersPerHour)
                return "\(velocity)"
            }()
            driveView.mapResult.text = {
                if(driveView.mapResult.text == "0 km"){
                    startMilage = Measurement(value: Double(message.milage), unit: UnitLength.kilometers)
                }
                
                let milage = Measurement(value: Double(message.milage), unit: UnitLength.kilometers) - startMilage
                return "\(milage)"
            }()
            
        }
        if let message = (data as? [BatteryLevelMessage])?.last {
            driveView.batteryLifeResult.text = {
                let batteryLife = message.level
                if(driveView.batteryLifeResult.text == "00 %"){
                    startBat = message.level
                }
                return "\(batteryLife) %"
            }()
        }
    }
    
    func connect(_ connection: Connect, failedToSendCommand command: ATCommandProtocol, dueToErrorOfKind kind: CommandError) {
        print("Failed to send ATCommand: \(command) reason: \(kind)")
    }
    
    func connect(_ connection: Connect, didEncounterReadError error: Error) {
        print("Read error, reason: \(error)")
    }
    
    func connectDidReceiveEndEncountered(_ connection: Connect) {
        print("Received end encounter")
    }
    
    func connect(_ connection: Connect, didDisconnectFromHost host: String) {
        print("Disconnected from \(host)")
        
        //Change button to connect btn
        driveView.startLabel.text = "Start collecting data"
        driveView.connectButton.isHidden = false
        driveView.disconnectButton.isHidden = true
    }
}
