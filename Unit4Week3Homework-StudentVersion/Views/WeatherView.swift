//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    //Message Label
    lazy var messageLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .yellow
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Weather Forecast for..."
        return label
    }()
    
    //Collection View
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .green
        //register collectionViewCell
        cv.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return cv
    }()
    
    
    //TextField
    lazy var textField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.922, green: 0.259, blue: 0.184, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        tField.textAlignment = .center
        tField.placeholder = "12345"
        tField.keyboardType = .numbersAndPunctuation
        tField.keyboardAppearance = .dark
        return tField
    }()
    
    
    //Zipcode Message Label
    lazy var zipcodeMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.backgroundColor = .clear
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Enter a Zone Improvement Plan Code"
        return label
    }()


    //Initialization
    override init(frame: CGRect) {//overriding the parent class's functions
        super.init(frame: UIScreen.main.bounds)
        setUpGUI()
    }
    
    required init?(coder aDecoder: NSCoder) { //now the new initializer required for this uiView
        super.init(coder: aDecoder)
        //setUpGUI()
    }
    
    private func setUpGUI() {
        backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects() {
        
        //ARRAY MUST BE ON ORDER!!
        let weatherViewObjects = [messageLabel, collectionView, textField, zipcodeMessageLabel] as [UIView]
        
        weatherViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //Weather Message Label
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            
            //Collection View
            collectionView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            
            //TextField
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            
            //Zipcode Message Label
            zipcodeMessageLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            zipcodeMessageLabel.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            zipcodeMessageLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
            
            ])
    }
}
