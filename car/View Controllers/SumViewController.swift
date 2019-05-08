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
        sumView.batteryUsageResult.text = "\(sum.batteryUsage) %"
        
        //This calculation is based on the Smart specification
        let kWh = (sum.batteryUsage * 13.2) / 100
        let kWhRound = (kWh*100).rounded() / 100
        
        //Calculate effeciency
        let subS = String(sumView.mapResult.text!.dropLast(3))
        let distance = Double(subS)
        
        let idealkWh = distance! * 0.12
        
        var effeciency = 0.0
        if idealkWh != 0 {
            effeciency = ((kWh / idealkWh) * 100).rounded()
        }
        
        if effeciency != 0.0 {
            sumView.efficiencyResult.text = "\(effeciency) %"
        } else {
            sumView.efficiencyResult.text = "--%"
        }
        
        sumView.efficiencyExplain.text = "The efficiency is based by the numbers provided by Smart Car that states you can drive 1 km per 0,12 kWh. You have driven \(sumView.mapResult.text!), and used \(sum.batteryUsage) % battery. This means you have used \(kWhRound) kWh, and your efficiency is therefor \(sumView.efficiencyResult.text!). "
    }
}
