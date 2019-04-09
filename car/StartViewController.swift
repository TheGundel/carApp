//
//  StartViewController.swift
//  car
//
//  Created by Sara Nordberg on 13/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: UIViewController, ConnectDelegate {
    
    let logo = UIImageView()
    let name = UILabel()
    let startLabel = UILabel()
    let startBtn = UIButton()
    private var connection: Connect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        connection = Connect()
        connection.delegate = self
    }
    
    func setupView() {
        
        logo.image = UIImage(named: "leafGreen")
        
        name.text = "Eco Drive"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        view.addSubview(logo)
        view.addSubview(name)
        
        startLabel.text = "Start collecting data"
        startLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        view.addSubview(startLabel)
        
        startBtn.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        startBtn.setTitle("Start", for: .normal)
        startBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startBtn.layer.cornerRadius = 25
        startBtn.clipsToBounds = true
        startBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        view.addSubview(startBtn)
    }
    
    func setupConstraints() {
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: logo.bottomAnchor).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 80).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startBtn.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10).isActive = true
        startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func openNewVC(sender: UIButton!) {
        let vc = ViewController()
        present(vc, animated: false, completion: nil)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Trying to connect")
        startLabel.text = "Trying to connect..."
        if connection.isConnected {
            connection.disconnect()
        } else {
            connection.connect()
            if connection.isConnected {
                let vc = ViewController()
                present(vc, animated: false, completion: nil)
            }
        }
    }
    
    func connect(_ connection: Connect, failedToConnectToHost host: String, withError error: Error?) {
        print("Failed to connect to \(host) reason: \(error?.localizedDescription ?? "")")
        
        let alert = UIAlertController(title: "Failed to Connect", message: "Failed to connect to OBD, please check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        startLabel.text = "Start collecting data"
        
    }
    
    func connect(_ connection: Connect, didConnectToHost host: String) {
        print("Connected to \(host)")
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            connection.send(command: AdHocCommand.initiate)
        }
        let vc = ViewController()
        present(vc, animated: false, completion: nil)
    }
    
    func connect(_ connection: Connect, didReceiveDataCollection dataCollection: CanMessageCollection) {
        print("Received Data:", dataCollection)
        
        //guard let data = dataCollection.data(for: connection.pid) else { return }
//        if let message = (data as? [OdometerMessage])?.last {
//            speedResult.text = {
//                let velocity = Measurement(value: Double(message.velocity), unit: UnitSpeed.kilometersPerHour)
//                return "\(velocity)"//formatter.string(from: velocity)
//            }()
//        }
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
