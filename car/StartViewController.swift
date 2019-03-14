//
//  StartViewController.swift
//  car
//
//  Created by Sara Nordberg on 13/03/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    let logo = UIImageView()
    let name = UILabel()
    let startLabel = UILabel()
    let startBtn = UIButton()
    let stopBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
        logo.image = UIImage(named: "leafGreen")
        
        name.text = "Good name"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        view.addSubview(logo)
        view.addSubview(name)
        
        startLabel.text = "Start calculations" //maybe a better text here
        startLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        view.addSubview(startLabel)
        
        startBtn.backgroundColor = UIColor(red:0.44, green:0.75, blue:0.13, alpha:1.0)
        startBtn.setTitle("Start", for: .normal)
        startBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startBtn.layer.cornerRadius = 25
        startBtn.clipsToBounds = true
        startBtn.addTarget(self, action: #selector(openNewVC(sender:)), for: .touchUpInside)
        
        stopBtn.backgroundColor = .red
        stopBtn.setTitle("Stop", for: .normal)
        stopBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        stopBtn.layer.cornerRadius = 25
        stopBtn.clipsToBounds = true
        //stopBtn.addTarget(self, action: #selector(openNewVC(sender:)), for: .touchUpInside)
        
        view.addSubview(startBtn)
        view.addSubview(stopBtn)
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
    
}
