//
//  ViewController.swift
//  car
//
//  Created by Sara Nordberg on 26/02/2019.
//  Copyright © 2019 Sara Nordberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let firstText = UILabel()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
//        collectionView.isScrollEnabled = true
//        collectionView.backgroundColor = .red
//        collectionView.register(MainView.self, forCellWithReuseIdentifier: MainView.reuseIdentifier)
//        view.addSubview(collectionView)
        firstText.text = "Hej"
        view.addSubview(firstText)
    }
    
    func setupConstraints() {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        firstText.translatesAutoresizingMaskIntoConstraints = false
        firstText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

