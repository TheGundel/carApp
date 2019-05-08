//
//  DriveView.swift
//  car
//
//  Created by Sara Nordberg on 06/05/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class DriveView: UIView {
    let topbar = UIImageView()
    let logo = UIImageView()
    let name = UILabel()
    let firstTitle = UILabel()
    
    let mapIcon = UIImageView()
    let timeIcon = UIImageView()
    let speedIcon = UIImageView()
    let batteryLifeIcon = UIImageView()
    
    let mapText = UILabel()
    let timeText = UILabel()
    let speedText = UILabel()
    let batteryLifeText = UILabel()
    
    let mapResult = UILabel()
    let timeResult = UILabel()
    let speedResult = UILabel()
    let batteryLifeResult = UILabel()
    
    let connectButton = UIButton()
    let disconnectButton = UIButton()
    let startLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        topbar.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        addSubview(topbar)
        
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
        
        addSubview(mapIcon)
        addSubview(mapText)
        addSubview(mapResult)
        
        timeIcon.image = UIImage(named: "timeIcon")
        
        timeText.text = "Time duration"
        timeText.font = UIFont.boldSystemFont(ofSize: 14)
        timeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        timeResult.text = "00:00.0"
        timeResult.font = timeResult.font.withSize(30)
        
        addSubview(timeIcon)
        addSubview(timeText)
        addSubview(timeResult)
        
        speedIcon.image = UIImage(named: "speedIcon")
        
        speedText.text = "Average speed"
        speedText.font = UIFont.boldSystemFont(ofSize: 14)
        speedText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        speedResult.text = "00 km/h"
        speedResult.font = speedResult.font.withSize(30)
        
        addSubview(speedIcon)
        addSubview(speedText)
        addSubview(speedResult)
        
        batteryLifeIcon.image = UIImage(named: "batteryLifeIcon")
        
        batteryLifeText.text = "Battery % left"
        batteryLifeText.font = UIFont.boldSystemFont(ofSize: 14)
        batteryLifeText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        batteryLifeResult.text = "00 %"
        batteryLifeResult.font = speedResult.font.withSize(30)
        
        addSubview(batteryLifeIcon)
        addSubview(batteryLifeText)
        addSubview(batteryLifeResult)
        
        startLabel.text = "Start collecting data"
        startLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(startLabel)
        
        connectButton.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        connectButton.setTitle("Start", for: .normal)
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        connectButton.layer.cornerRadius = 25
        addSubview(connectButton)
        
        disconnectButton.backgroundColor = .red
        disconnectButton.setTitle("Stop", for: .normal)
        disconnectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        disconnectButton.layer.cornerRadius = 25
        addSubview(disconnectButton)
        
    }
    
    func setupConstraints() {
        
        topbar.translatesAutoresizingMaskIntoConstraints = false
        topbar.heightAnchor.constraint(equalToConstant: 20+60).isActive = true //20 is the height of the statusbar, so we add the wanted size to that number
        topbar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topbar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topbar.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
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
        mapIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -60).isActive = true
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
        timeIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
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
        speedIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
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
        batteryLifeIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -60).isActive = true
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
        connectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        connectButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        connectButton.isHidden = false
        
        disconnectButton.translatesAutoresizingMaskIntoConstraints = false
        disconnectButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        disconnectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        disconnectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        disconnectButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        disconnectButton.isHidden = true
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -10).isActive = true
        startLabel.centerXAnchor.constraint(equalTo: connectButton.centerXAnchor).isActive = true
        
    }
}
