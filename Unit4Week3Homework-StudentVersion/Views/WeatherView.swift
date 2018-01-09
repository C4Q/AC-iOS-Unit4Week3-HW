//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.blue
//        cv.layer.cornerRadius = 10.0
//        cv.layer.masksToBounds = true
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "WeatherViewCell")
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return cv
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Here is your text label."
        label.backgroundColor = UIColor.brown
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    
    lazy var weatherTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Place Zip Here"
        textField.backgroundColor = UIColor.green
        return textField
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.cyan
        setupViews()
        setUpCollectionViewConstraints()
        setUpNameLabelConstraints()
        setUpWeatherTextField()
    }
    
    private func setupViews() {
        let weatherItems = [weatherTextField, cityNameLabel, weatherCollectionView] as [UIView]
        weatherItems.forEach{ addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false }
        
    }
    
    private func setUpCollectionViewConstraints() {
        NSLayoutConstraint.activate([weatherCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            weatherCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
            
            ])
    }
    
    private func setUpNameLabelConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -250),
            cityNameLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06),
            cityNameLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),

    ])
    }
    
    private func setUpWeatherTextField() {
NSLayoutConstraint.activate([
    weatherTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
    weatherTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 250),
    weatherTextField.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
    weatherTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
    
    ])
        
    }
    
    
    
    
}
