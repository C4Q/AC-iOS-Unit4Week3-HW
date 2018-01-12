//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    lazy var titleLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "7 Day Forecast"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 250))
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame:self.bounds, collectionViewLayout: layout)
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var zipTextField: UITextField = {
        let zipTextField = UITextField()
        zipTextField.placeholder = "Enter Zipcode Here"
        zipTextField.backgroundColor = .white
        zipTextField.alpha = 0.9
        zipTextField.textAlignment = .center
        zipTextField.layer.cornerRadius = 5.0
        return zipTextField
    }()
    
    lazy var enterZipLabel: UILabel = {
        let enterZipLabel = UILabel()
        enterZipLabel.textAlignment = .center
        enterZipLabel.textColor = .white
        enterZipLabel.text = "Enter a Zip Code"
        return enterZipLabel
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sunset.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
       insertSubview(backgroundImage, at: 0)
        setupViews()
    }
    
    private func setupViews() {
        setuptitleLabel()
        setupCollectionView()
        setupZipTextField()
        setupEnterZipLabel()
    }
    
    func setuptitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupZipTextField() {
        addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        zipTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        zipTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        zipTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupEnterZipLabel() {
        addSubview(enterZipLabel)
        enterZipLabel.translatesAutoresizingMaskIntoConstraints = false
        enterZipLabel.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20).isActive = true
        enterZipLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        enterZipLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    
}
