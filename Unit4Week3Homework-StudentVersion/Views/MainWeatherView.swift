//
//  MainWeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherView: UIView {
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "New York City"
        return label
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame:self.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .yellow
        cv.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    
    lazy var zipTextField: UITextField = {
        let ztf = UITextField()
        ztf.textAlignment = .center
        ztf.placeholder = "  Zip code    "
        ztf.borderStyle = .roundedRect
        ztf.keyboardType = .numberPad
        return ztf
    }()
    
    lazy var insLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Enter a Zip code"
        return label
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupCityLabel()
        setupCollectionView()
        setupZipTF()
        setupInstLabel()
    }
    
    private func setupCollectionView() {
        addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        weatherCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 40).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupCityLabel() {
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    
    private func setupZipTF() {
        addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        zipTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        zipTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 30).isActive = true
    }
    
    private func setupInstLabel() {
        addSubview(insLabel)
        insLabel.translatesAutoresizingMaskIntoConstraints = false
        insLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        insLabel.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20).isActive = true
    }
    
}


