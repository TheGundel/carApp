//
//  DriveViewController.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import UIKit

class DriveViewController: UIViewController, ConnectDelegate {
    
//    var scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentSize.height = 1500
//
//        return view
//    }()
    
    let topbar = UIImageView()
    let logo = UIImageView()
    let name = UILabel()
    let firstTitle = UILabel()
    
    let mapIcon = UIImageView()
    let timeIcon = UIImageView()
    let speedIcon = UIImageView()
    //let batteryUsageIcon = UIImageView()
    let batteryLifeIcon = UIImageView()
    
    let mapText = UILabel()
    let timeText = UILabel()
    let speedText = UILabel()
    //let batteryUsageText = UILabel()
    let batteryLifeText = UILabel()
    
    let mapResult = UILabel()
    let timeResult = UILabel()
    let speedResult = UILabel()
    //let batteryUsageResult = UILabel()
    let batteryLifeResult = UILabel()
    
    let watch = StopWatch()
    
    let connectButton = UIButton()
    let disconnectButton = UIButton()
    let startLabel = UILabel()
    
    private var connection: Connect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //view.addSubview(scrollView)
        setupScrollView()
        setupView()
        setupConstraints()
        
        connection = Connect()
        connection.delegate = self
    }
    
    func setupScrollView() {
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func setupView() {
        
        topbar.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        view.addSubview(topbar)
        
        logo.image = UIImage(named: "leafWhite")
        name.text = "Eco Drive"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.textColor = .white
        topbar.addSubview(name)
        topbar.addSubview(logo)
        
        mapIcon.image = UIImage(named: "mapIcon")
        
        mapText.text = "Distance travelled"
        mapText.font = UIFont.boldSystemFont(ofSize: 14)
        mapText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        mapResult.text = "0 km"
        mapResult.font = mapResult.font.withSize(30)
        
        view.addSubview(mapIcon)
        view.addSubview(mapText)
        view.addSubview(mapResult)
        
        timeIcon.image = UIImage(named: "timeIcon")
        
        timeText.text = "Time duration"
        timeText.font = UIFont.boldSystemFont(ofSize: 14)
        timeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        timeResult.text = "00:00.0"
        timeResult.font = timeResult.font.withSize(30)
        
        view.addSubview(timeIcon)
        view.addSubview(timeText)
        view.addSubview(timeResult)
        
        speedIcon.image = UIImage(named: "speedIcon")
        
        speedText.text = "Average speed"
        speedText.font = UIFont.boldSystemFont(ofSize: 14)
        speedText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        speedResult.text = "00 km/t"
        speedResult.font = speedResult.font.withSize(30)
        
        view.addSubview(speedIcon)
        view.addSubview(speedText)
        view.addSubview(speedResult)
        
        batteryLifeIcon.image = UIImage(named: "batteryLifeIcon")
        
        batteryLifeText.text = "Battery % left"
        batteryLifeText.font = UIFont.boldSystemFont(ofSize: 14)
        batteryLifeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        batteryLifeResult.text = "00 %"
        batteryLifeResult.font = speedResult.font.withSize(30)
        
        view.addSubview(batteryLifeIcon)
        view.addSubview(batteryLifeText)
        view.addSubview(batteryLifeResult)
        
        startLabel.text = "Start collecting data"
        startLabel.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(startLabel)
        
        connectButton.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        connectButton.setTitle("Start", for: .normal)
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        connectButton.layer.cornerRadius = 25
        connectButton.addTarget(self, action: #selector(connect(sender:)), for: .touchUpInside)
        view.addSubview(connectButton)
        
        disconnectButton.backgroundColor = .red
        disconnectButton.setTitle("Stop", for: .normal)
        disconnectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        disconnectButton.layer.cornerRadius = 25
        disconnectButton.addTarget(self, action: #selector(disconnect(sender:)), for: .touchUpInside)
        view.addSubview(disconnectButton)
    
    }
    
    func setupConstraints() {
        
        topbar.translatesAutoresizingMaskIntoConstraints = false
        topbar.heightAnchor.constraint(equalToConstant: 20+60).isActive = true //20 is the height of the statusbar, so we add the wanted size to that number
        topbar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        logo.bottomAnchor.constraint(equalTo: topbar.bottomAnchor, constant: -10).isActive = true
        logo.leftAnchor.constraint(equalTo: topbar.leftAnchor, constant: 15).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 15).isActive = true
        name.centerYAnchor.constraint(equalTo: logo.centerYAnchor).isActive = true
        
        mapIcon.translatesAutoresizingMaskIntoConstraints = false
        mapIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        mapIcon.topAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 40).isActive = true
        
        mapText.translatesAutoresizingMaskIntoConstraints = false
        mapText.topAnchor.constraint(equalTo: mapIcon.bottomAnchor, constant: 10).isActive = true
        mapText.centerXAnchor.constraint(equalTo: mapIcon.centerXAnchor).isActive = true
        
        mapResult.translatesAutoresizingMaskIntoConstraints = false
        mapResult.topAnchor.constraint(equalTo: mapText.bottomAnchor, constant: 10).isActive = true
        mapResult.centerXAnchor.constraint(equalTo: mapText.centerXAnchor).isActive = true
        
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        timeIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        timeIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        timeIcon.topAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 40).isActive = true
        
        timeText.translatesAutoresizingMaskIntoConstraints = false
        timeText.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: 10).isActive = true
        timeText.centerXAnchor.constraint(equalTo: timeIcon.centerXAnchor).isActive = true
        
        timeResult.translatesAutoresizingMaskIntoConstraints = false
        timeResult.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 10).isActive = true
        timeResult.centerXAnchor.constraint(equalTo: timeText.centerXAnchor).isActive = true
        
        speedIcon.translatesAutoresizingMaskIntoConstraints = false
        speedIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        speedIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        speedIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        speedIcon.topAnchor.constraint(equalTo: timeResult.bottomAnchor, constant: 30).isActive = true
        
        speedText.translatesAutoresizingMaskIntoConstraints = false
        speedText.topAnchor.constraint(equalTo: speedIcon.bottomAnchor, constant: 10).isActive = true
        speedText.centerXAnchor.constraint(equalTo: speedIcon.centerXAnchor).isActive = true
        
        speedResult.translatesAutoresizingMaskIntoConstraints = false
        speedResult.topAnchor.constraint(equalTo: speedText.bottomAnchor, constant: 10).isActive = true
        speedResult.centerXAnchor.constraint(equalTo: speedText.centerXAnchor).isActive = true
        
        batteryLifeIcon.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        batteryLifeIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        batteryLifeIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        batteryLifeIcon.topAnchor.constraint(equalTo: mapResult.bottomAnchor, constant: 30).isActive = true
        
        batteryLifeText.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeText.topAnchor.constraint(equalTo: batteryLifeIcon.bottomAnchor, constant: 10).isActive = true
        batteryLifeText.centerXAnchor.constraint(equalTo: batteryLifeIcon.centerXAnchor).isActive = true
        
        batteryLifeResult.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeResult.topAnchor.constraint(equalTo: batteryLifeText.bottomAnchor, constant: 10).isActive = true
        batteryLifeResult.centerXAnchor.constraint(equalTo: batteryLifeText.centerXAnchor).isActive = true
        
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        connectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectButton.isHidden = false
        
        disconnectButton.translatesAutoresizingMaskIntoConstraints = false
        disconnectButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        disconnectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        disconnectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        disconnectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        disconnectButton.isHidden = true
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -10).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: connectButton.centerXAnchor).isActive = true

    }
    
    var running = false
    var timer: Timer?
    var time: TimeInterval = 5.0
    
    @objc func PIDChange() {
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
        startLabel.text = "Trying to connect to OBD II..."
        if connection.isConnected {
            connection.disconnect()
        } else {
            connection.connect()
        }
        
        if connection.isConnected {
            print("Hej")
        }
    }
    
    @objc func disconnect(sender: UIButton!) {
        print("Trying to disconnect")
        startLabel.text = "Disconnecting..."
        if connection.isConnected {
            connection.disconnect()
        }
        watch.stop()
    }
    
    @objc func updateElapsedTimeLabel(timer : Timer) {
        if watch.isRunning {
            let minutes = Int(watch.elapsedTime / 60)
            let seconds = Int(watch.elapsedTime)%60
            let tenOfSeconds = Int(watch.elapsedTime * 10) % 10
            timeResult.text = String(format: "%02d:%02d.%d", minutes, seconds, tenOfSeconds)
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
        
        //Reset label
        startLabel.text = "Start collecting data"
    }
    
    func connect(_ connection: Connect, didConnectToHost host: String) {
        print("Connected to \(host)")
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            connection.send(command: AdHocCommand.initiate)
        }
        //Change PID after initial setup connection
        PIDChange()
        
        //Change button to disconnect btn
        startLabel.text = "Stop collecting data"
        connectButton.isHidden = true
        disconnectButton.isHidden = false
        
    }
    
    var startMilage = Measurement(value: 0, unit: UnitLength.kilometers)
    
    private let formatter = MeasurementFormatter()
    
    func connect(_ connection: Connect, didReceiveDataCollection dataCollection: CanMessageCollection) {
        if(!watch.isRunning){
            watch.start()
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
        }
        print("Received Data:", dataCollection)
        
        guard let data = dataCollection.data(for: connection.pid) else { return }
        if let message = (data as? [OdometerMessage])?.last {
            speedResult.text = {
                let velocity = Measurement(value: Double(message.velocity), unit: UnitSpeed.kilometersPerHour)
                return "\(velocity)"
            }()
            mapResult.text = {
                if(mapResult.text == "0 km"){
                    startMilage = Measurement(value: Double(message.milage), unit: UnitLength.kilometers)
                }
                
                let milage = Measurement(value: Double(message.milage), unit: UnitLength.kilometers) - startMilage
                return "\(milage)"
            }()
            
        }
        if let message = (data as? [BatteryLevelMessage])?.last {
            batteryLifeResult.text = {
                let batteryLife = message.level
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
        startLabel.text = "Start collecting data"
        connectButton.isHidden = false
        disconnectButton.isHidden = true
    }
    
    
}

