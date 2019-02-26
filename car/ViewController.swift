//
//  ViewController.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topbar = UIImageView()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
        topbar.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        view.addSubview(topbar)
        
        firstTitle.text = "Summary of latest drive"
        firstTitle.font = firstTitle.font.withSize(22)
        view.addSubview(firstTitle)
        
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
        
        timeResult.text = "00:00 min"
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
        
    }
    
    func setupConstraints() {
        
        topbar.translatesAutoresizingMaskIntoConstraints = false
        topbar.heightAnchor.constraint(equalToConstant: 20+60).isActive = true //20 is the height of the statusbar, so we add the wanted size to that number
        topbar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        firstTitle.translatesAutoresizingMaskIntoConstraints = false
        firstTitle.topAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 20).isActive = true
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
    }

}

//CODE WE MIGHT NEED LATER :-)

//    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

//        collectionView.isScrollEnabled = true
//        collectionView.backgroundColor = .red
//        collectionView.register(MainView.self, forCellWithReuseIdentifier: MainView.reuseIdentifier)
//        view.addSubview(collectionView)

//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
