//
//  SumViewController.swift
//  car
//
//  Created by Sara Nordberg on 06/05/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class SumViewController: UIViewController {
    
    var sumView = SumView()
    
    override func loadView() {
        view = sumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumView.resetButton.addTarget(self, action: #selector(reset(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        updateView()
    }
    
    @objc func reset(sender: UIButton!) {
        let vc = DriveViewController()
        present(vc, animated: false, completion: nil)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var summary: [Summary] = []
    
    func getCoreData() {
        do {
            summary = try context.fetch(Summary.fetchRequest())
            print(summary.count)
        } catch {
            print("Fetching Failed")
        }
    }
    
    func updateView() {
        let sum = summary[0]
        
        if let distance = sum.distance {
            sumView.mapResult.text = distance
        }
        if let battery = sum.battery {
            sumView.batteryLifeResult.text = battery
        }
        if let time = sum.time {
            sumView.timeResult.text = time
        }
        
        //This calculation is based on the Smart specification
        let kW = sum.batteryUsage * 0.3
        sumView.batteryUsageResult.text = "\(kW) kW"
        
        //Calculate effeciency
        let idealDist = kW * 3.6
        
        let subS = String(sumView.mapResult.text!.dropLast(3))
        let distance = Double(subS)
        
        var effeciency = 0.0
        if idealDist != 0 {
            effeciency = (distance! / idealDist) * 100
        }
        
        if effeciency != 0.0 {
            sumView.efficiencyResult.text = "\(effeciency) %"
        } else {
            sumView.efficiencyResult.text = "--%"
        }
        
        sumView.efficiencyExplain.text = "The efficiency is based by the numbers provided by Smart Car that states you can drive 3,6 km per kW. You have driven \(sumView.mapResult.text!), and used \(sum.batteryUsage) % battery. This means you have used \(sumView.batteryUsageResult.text!), and your efficiency is therefor \(sumView.efficiencyResult.text!). "
    }
}
