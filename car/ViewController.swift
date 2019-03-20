//
//  ViewController.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ConnectDelegate {
    
    var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1500
        
        return view
    }()
    
    let topbar = UIImageView()
    let logo = UIImageView()
    let name = UILabel()
    let firstTitle = UILabel()
    
    let mapIcon = UIImageView()
    let timeIcon = UIImageView()
    let speedIcon = UIImageView()
    let batteryUsageIcon = UIImageView()
    let batteryLifeIcon = UIImageView()
    
    let mapText = UILabel()
    let timeText = UILabel()
    let speedText = UILabel()
    let batteryUsageText = UILabel()
    let batteryLifeText = UILabel()
    
    let mapResult = UILabel()
    let timeResult = UILabel()
    let speedResult = UILabel()
    let batteryUsageResult = UILabel()
    let batteryLifeResult = UILabel()
    
    let efficiencyLabel = UILabel()
    let efficiencyResult = UILabel()
    
    let separator = UIView()
    
    private var connection: Connect!
    let connectButton = UIButton()
    let disconnectButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(scrollView)
        setupScrollView()
        setupView()
        setupConstraints()
        
        connection = Connect()
        connection.delegate = self
    }
    
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Trying to connect")
        if connection.isConnected {
            connection.disconnect()
        } else {
            connection.connect()
        }
    }
    
    @objc func disconnect(sender: UIButton!) {
        print("Trying to disconnect")
        if connection.isConnected {
            connection.disconnect()
        }
    }
    
    func setupView() {
        
        connectButton.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        connectButton.backgroundColor = .green
        connectButton.setTitle("Connect", for: .normal)
        connectButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        scrollView.addSubview(connectButton)
        
        disconnectButton.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        disconnectButton.backgroundColor = .red
        disconnectButton.setTitle("Disconnect", for: .normal)
        disconnectButton.addTarget(self, action: #selector(disconnect(sender:)), for: .touchUpInside)
        scrollView.addSubview(disconnectButton)
        
        topbar.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        view.addSubview(topbar)
        
        logo.image = UIImage(named: "leafWhite")
        name.text = "Good Name"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.textColor = .white
        topbar.addSubview(name)
        topbar.addSubview(logo)
        
        firstTitle.text = "Summary of latest drive"
        firstTitle.font = firstTitle.font.withSize(22)
        scrollView.addSubview(firstTitle)
        
        mapIcon.image = UIImage(named: "mapIcon")
        
        mapText.text = "Distance travelled"
        mapText.font = UIFont.boldSystemFont(ofSize: 14)
        mapText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        mapResult.text = "0 km"
        mapResult.font = mapResult.font.withSize(30)
        
        scrollView.addSubview(mapIcon)
        scrollView.addSubview(mapText)
        scrollView.addSubview(mapResult)
        
        timeIcon.image = UIImage(named: "timeIcon")
        
        timeText.text = "Time duration"
        timeText.font = UIFont.boldSystemFont(ofSize: 14)
        timeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        timeResult.text = "00:00 min"
        timeResult.font = timeResult.font.withSize(30)
        
        scrollView.addSubview(timeIcon)
        scrollView.addSubview(timeText)
        scrollView.addSubview(timeResult)
        
        speedIcon.image = UIImage(named: "speedIcon")
        
        speedText.text = "Average speed"
        speedText.font = UIFont.boldSystemFont(ofSize: 14)
        speedText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        speedResult.text = "00 km/t"
        speedResult.font = speedResult.font.withSize(30)
        
        scrollView.addSubview(speedIcon)
        scrollView.addSubview(speedText)
        scrollView.addSubview(speedResult)
        
        batteryUsageIcon.image = UIImage(named: "batteryUsageIcon")
        
        batteryUsageText.text = "Battery used"
        batteryUsageText.font = UIFont.boldSystemFont(ofSize: 14)
        batteryUsageText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        batteryUsageResult.text = "00 kwh"
        batteryUsageResult.font = speedResult.font.withSize(30)
        
        scrollView.addSubview(batteryUsageIcon)
        scrollView.addSubview(batteryUsageText)
        scrollView.addSubview(batteryUsageResult)
        
        batteryLifeIcon.image = UIImage(named: "batteryLifeIcon")
        
        batteryLifeText.text = "Battery % left"
        batteryLifeText.font = UIFont.boldSystemFont(ofSize: 14)
        batteryLifeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        batteryLifeResult.text = "00 %"
        batteryLifeResult.font = speedResult.font.withSize(30)
        
        scrollView.addSubview(batteryLifeIcon)
        scrollView.addSubview(batteryLifeText)
        scrollView.addSubview(batteryLifeResult)
        
        separator.backgroundColor = UIColor.lightGray
        scrollView.addSubview(separator)
        
        efficiencyLabel.text = "Efficieny"
        efficiencyLabel.font = UIFont.boldSystemFont(ofSize: 18)
        efficiencyLabel.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        efficiencyResult.text = "Some result"
        efficiencyResult.font = UIFont.boldSystemFont(ofSize: 16)
        
        scrollView.addSubview(efficiencyLabel)
        scrollView.addSubview(efficiencyResult)
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

        firstTitle.translatesAutoresizingMaskIntoConstraints = false
        firstTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        firstTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mapIcon.translatesAutoresizingMaskIntoConstraints = false
        mapIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        mapIcon.topAnchor.constraint(equalTo: firstTitle.bottomAnchor, constant: 40).isActive = true
        
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
        timeIcon.topAnchor.constraint(equalTo: firstTitle.bottomAnchor, constant: 40).isActive = true
        
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
        
        batteryUsageIcon.translatesAutoresizingMaskIntoConstraints = false
        batteryUsageIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        batteryUsageIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        batteryUsageIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        batteryUsageIcon.topAnchor.constraint(equalTo: mapResult.bottomAnchor, constant: 30).isActive = true
        
        batteryUsageText.translatesAutoresizingMaskIntoConstraints = false
        batteryUsageText.topAnchor.constraint(equalTo: batteryUsageIcon.bottomAnchor, constant: 10).isActive = true
        batteryUsageText.centerXAnchor.constraint(equalTo: batteryUsageIcon.centerXAnchor).isActive = true
        
        batteryUsageResult.translatesAutoresizingMaskIntoConstraints = false
        batteryUsageResult.topAnchor.constraint(equalTo: batteryUsageText.bottomAnchor, constant: 10).isActive = true
        batteryUsageResult.centerXAnchor.constraint(equalTo: batteryUsageText.centerXAnchor).isActive = true
        
        batteryLifeIcon.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        batteryLifeIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        batteryLifeIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        batteryLifeIcon.topAnchor.constraint(equalTo: speedResult.bottomAnchor, constant: 30).isActive = true
        
        batteryLifeText.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeText.topAnchor.constraint(equalTo: batteryLifeIcon.bottomAnchor, constant: 10).isActive = true
        batteryLifeText.centerXAnchor.constraint(equalTo: batteryLifeIcon.centerXAnchor).isActive = true
        
        batteryLifeResult.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeResult.topAnchor.constraint(equalTo: batteryLifeText.bottomAnchor, constant: 10).isActive = true
        batteryLifeResult.centerXAnchor.constraint(equalTo: batteryLifeText.centerXAnchor).isActive = true
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true
        separator.topAnchor.constraint(equalTo: batteryLifeResult.bottomAnchor, constant: 25).isActive = true
        separator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        efficiencyLabel.translatesAutoresizingMaskIntoConstraints = false
        efficiencyLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 30).isActive = true
        efficiencyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        efficiencyResult.translatesAutoresizingMaskIntoConstraints = false
        efficiencyResult.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 30).isActive = true
        efficiencyResult.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.topAnchor.constraint(equalTo: efficiencyLabel.bottomAnchor, constant: 20).isActive = true
        connectButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        disconnectButton.translatesAutoresizingMaskIntoConstraints = false
        disconnectButton.topAnchor.constraint(equalTo: efficiencyLabel.bottomAnchor, constant: 20).isActive = true
        disconnectButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    }
    
    func connect(_ connection: Connect, failedToConnectToHost host: String, withError error: Error?) {
        print("Failed to connect to \(host) reason: \(error?.localizedDescription ?? "")")
    }
    
    func connect(_ connection: Connect, didConnectToHost host: String) {
        print("Connected to \(host)")
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            connection.send(command: AdHocCommand.initiate)
        }

    }
    private let formatter = MeasurementFormatter()

    func connect(_ connection: Connect, didReceiveDataCollection dataCollection: CanMessageCollection) {
        print("Received Data:", dataCollection)
        
        guard let data = dataCollection.data(for: connection.pid) else { return }
        if let message = (data as? [OdometerMessage])?.last {
            speedResult.text = {
                let velocity = Measurement(value: Double(message.velocity), unit: UnitSpeed.kilometersPerHour)
                return "\(velocity)"//formatter.string(from: velocity)
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
    }
    
    
}

