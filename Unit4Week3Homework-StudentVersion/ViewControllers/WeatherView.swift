//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Forcast for "
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium )
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: bounds, collectionViewLayout: layout)
        cv.backgroundColor = .darkGray
        cv.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    
    lazy var zipCodeInput: UITextField = {
        let zipInput = UITextField()
        zipInput.placeholder = "Enter Zip Code"
        zipInput.textAlignment = .center
        zipInput.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        zipInput.borderStyle = .roundedRect
        //This is for a custom border. 
//        zipInput.layer.borderWidth = 6
//        zipInput.layer.borderColor = UIColor.black.cgColor
//        zipInput.layer.cornerRadius = 20
//        zipInput.layer.masksToBounds = true
        zipInput.keyboardType = .numberPad
        let keyboardAppearance = UITextField.appearance()
        keyboardAppearance.keyboardAppearance = .dark
        return zipInput
    }()
    
    
    let margin: CGFloat = 20
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.darkGray
        setupViews()
    }
    
    private func setupViews() {
        setupTopLabel()
        setupColectionView()
        setupZipCodeInput()
    }
    
    
    private func setupTopLabel() {
        addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [topLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
             topLabel.widthAnchor.constraint(equalTo: widthAnchor),
             topLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setupColectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: margin),
             collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
             collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35)
            ])
    }
    
    private func setupZipCodeInput() {
        addSubview(zipCodeInput)
        zipCodeInput.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [zipCodeInput.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
             zipCodeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
             zipCodeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)])
    }
    
    
    
    
}
