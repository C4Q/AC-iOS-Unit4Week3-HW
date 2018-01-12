//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {

    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "7 Day Forecast"
//        label.textAlignment = .center
//        return label
//    }()
//
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    
        let CV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        CV.backgroundColor = .white
        CV.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        return CV
        }()
    
    
    lazy var zipTextField: UITextField = {
        let TF = UITextField()
        TF.placeholder = "Enter Zip Code"
        TF.textAlignment = .center
        TF.borderStyle = .bezel
//        TF.keyboardType = .numberPad
      
        return TF
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
//        setupLabel()
        setupCollectionView()
        setupTextField()
    }
    
    
//
//    private func setupLabel() {
//        addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        let SF = safeAreaLayoutGuide
//        titleLabel.topAnchor.constraint(equalTo: SF.topAnchor, constant: 22).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: SF.trailingAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: SF.leadingAnchor).isActive = true
//        titleLabel.centerXAnchor.constraint(equalTo: SF.centerXAnchor).isActive = true
//
//    }

    private func setupCollectionView() {
        addSubview(collectionView)
        let SF = safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: SF.topAnchor, constant: 11).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: SF.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: SF.leadingAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: SF.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: SF.heightAnchor, multiplier: 0.8).isActive = true
        
    }
    
    
    private func setupTextField(){
        addSubview(zipTextField)
        let SF = safeAreaLayoutGuide
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        zipTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 22).isActive = true
        zipTextField.widthAnchor.constraint(equalTo: SF.widthAnchor, multiplier: 0.5).isActive = true
        zipTextField.centerXAnchor.constraint(equalTo: SF.centerXAnchor).isActive = true
    }
    
}

