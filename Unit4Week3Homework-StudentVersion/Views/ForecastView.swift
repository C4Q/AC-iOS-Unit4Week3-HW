//
//  ForecastView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastView: UIView {
    
    // Label to display city name
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.minimumScaleFactor = 0.50
        return label
    }()
    
    // City label constraints
    private func setupCityNameLabel() {
        addSubview(cityNameLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            cityNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            cityNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
            ])
    }
    
    // Collection view
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "ForecastCell")
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()
    
    // Collection view constraints
    private func setupCollectionView() {
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.40)
            ])

    }
    
    // Text field for the user to initiate search
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.borderStyle = .roundedRect
        textField.tintColor = .blue
        textField.placeholder = "Enter a zip code."
        return textField
    }()
    
    // Text field constraints
    private func setupSearchTextField() {
        addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            searchTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0),
            searchTextField.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.50)
            ])
        
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .darkGray
        setupViews()
    }
    
    private func setupViews() {
        setupCityNameLabel()
        setupCollectionView()
        setupSearchTextField()

    }
    
    
}

