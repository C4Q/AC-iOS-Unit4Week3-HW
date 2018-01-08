//
//  ForecastView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastView: UIView {
    
    let cellSpacing = UIScreen.main.bounds.width * 0.01

    var forecasts = [Forecast]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // Label to display city name
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "NEW YORK CITY"
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
        
        collectionView.backgroundColor = .orange
        
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
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
    }
    
    // Text field for the user to initiate search
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.borderStyle = .roundedRect
        textField.tintColor = .blue
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
    
    // Search by zip code button
    lazy var searchByZipButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        
        button.setTitleColor(.green, for: .normal)
        button.setTitle("Zip Code", for: .normal)
        
        button.setTitleColor(.red, for: .disabled)
        
        button.backgroundColor = .purple
        
        return button
    }()
    
    // Zip button constraints
    private func setupSearchByZipButton() {
        addSubview(searchByZipButton)
        
        searchByZipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchByZipButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0),
            searchByZipButton.trailingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: -5)
            ])
    }
    
    // Search by city button
    lazy var searchByCityButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        
        button.setTitleColor(.green, for: .normal)
        button.setTitle("City Name", for: .normal)
        
        button.setTitleColor(.red, for: .disabled)
        
        button.backgroundColor = .purple
        
        return button
    }()
    
    // City button constraints
    private func setupSearchByCityButton() {
        addSubview(searchByCityButton)
        
        searchByCityButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchByCityButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0),
            searchByCityButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 5)
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
        backgroundColor = .purple
        setupViews()
        searchByZipButton.isEnabled = false
    }
    
    private func setupViews() {
        setupCityNameLabel()
        setupCollectionView()
        setupSearchTextField()
        setupSearchByZipButton()
        setupSearchByCityButton()
    }
    
    
    
}

extension ForecastView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath)
        
        return cell
    }
    
}

extension ForecastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: collectionView.bounds.height * 0.90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

extension ForecastView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}

