//
//  MainView.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import Foundation
import UIKit

class MainView: UICollectionViewCell {
    let john = UILabel()
    
    static let reuseIdentifier = "MainView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        john.text = "Hej"
        contentView.addSubview(john)
    }
    
    func setupConstraints() {
        john.translatesAutoresizingMaskIntoConstraints = false
        john.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        john.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
