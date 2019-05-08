//
//  SumView.swift
//  car
//
//  Created by Sara Nordberg on 06/05/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class SumView: UIView {
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 900
        
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
    let efficiencyIcon = UIImageView()
    
    let mapText = UILabel()
    let timeText = UILabel()
    let speedText = UILabel()
    let batteryUsageText = UILabel()
    let batteryLifeText = UILabel()
    let efficiencyText = UILabel()
    
    let mapResult = UILabel()
    let timeResult = UILabel()
    let speedResult = UILabel()
    let batteryUsageResult = UILabel()
    let batteryLifeResult = UILabel()
    let efficiencyResult = UILabel()
    
    let separator = UIView()
    let efficiencyExplain = UILabel()
    let resetButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(scrollView)
        
        setupScrollView()
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
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
        
        speedResult.text = "-- km/h"
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
        
        efficiencyIcon.image = UIImage(named: "leafGrey")
        
        efficiencyText.text = "Efficiency"
        efficiencyText.font = UIFont.boldSystemFont(ofSize: 14)
        efficiencyText.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        efficiencyResult.text = "--%"
        efficiencyResult.font = efficiencyResult.font.withSize(30)
        
        scrollView.addSubview(efficiencyIcon)
        scrollView.addSubview(efficiencyText)
        scrollView.addSubview(efficiencyResult)
        
        separator.backgroundColor = UIColor.lightGray
        //separator.image = UIImage(named: "line")
        scrollView.addSubview(separator)
        
        efficiencyExplain.text = "Here your efficiency is explained."
        efficiencyExplain.font = efficiencyExplain.font.withSize(15)
        efficiencyExplain.numberOfLines = 0
        scrollView.addSubview(efficiencyExplain)
        
        resetButton.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        resetButton.layer.cornerRadius = 25
        resetButton.setTitle("Start new drive", for: .normal)
        addSubview(resetButton)
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
        
        firstTitle.translatesAutoresizingMaskIntoConstraints = false
        firstTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        firstTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        mapIcon.translatesAutoresizingMaskIntoConstraints = false
        mapIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        mapIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -60).isActive = true
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
        timeIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
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
        speedIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
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
        batteryUsageIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -60).isActive = true
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
        batteryLifeIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        batteryLifeIcon.topAnchor.constraint(equalTo: speedResult.bottomAnchor, constant: 30).isActive = true
        
        batteryLifeText.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeText.topAnchor.constraint(equalTo: batteryLifeIcon.bottomAnchor, constant: 10).isActive = true
        batteryLifeText.centerXAnchor.constraint(equalTo: batteryLifeIcon.centerXAnchor).isActive = true
        
        batteryLifeResult.translatesAutoresizingMaskIntoConstraints = false
        batteryLifeResult.topAnchor.constraint(equalTo: batteryLifeText.bottomAnchor, constant: 10).isActive = true
        batteryLifeResult.centerXAnchor.constraint(equalTo: batteryLifeText.centerXAnchor).isActive = true
        
        efficiencyIcon.translatesAutoresizingMaskIntoConstraints = false
        efficiencyIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        efficiencyIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        efficiencyIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -70).isActive = true
        efficiencyIcon.topAnchor.constraint(equalTo: batteryUsageResult.bottomAnchor, constant: 40).isActive = true
        
        efficiencyText.translatesAutoresizingMaskIntoConstraints = false
        efficiencyText.topAnchor.constraint(equalTo: efficiencyIcon.bottomAnchor, constant: 10).isActive = true
        efficiencyText.centerXAnchor.constraint(equalTo: efficiencyIcon.centerXAnchor).isActive = true
        
        efficiencyResult.translatesAutoresizingMaskIntoConstraints = false
        efficiencyResult.topAnchor.constraint(equalTo: efficiencyText.bottomAnchor, constant: 10).isActive = true
        efficiencyResult.centerXAnchor.constraint(equalTo: efficiencyText.centerXAnchor).isActive = true
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 330).isActive = true
        separator.topAnchor.constraint(equalTo: batteryLifeResult.bottomAnchor, constant: 25).isActive = true
        separator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        efficiencyExplain.translatesAutoresizingMaskIntoConstraints = false
        efficiencyExplain.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20).isActive = true
        efficiencyExplain.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        efficiencyExplain.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
}
