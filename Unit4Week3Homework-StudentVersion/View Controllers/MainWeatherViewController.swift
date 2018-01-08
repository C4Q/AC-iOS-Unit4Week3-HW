//
//  SearchViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    let cellSpacing: CGFloat = 5.0
    
    var weatherDays = [Weather]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy var nameCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast for N/A"
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.collectionViewStack.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(WeatherCVCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    
    lazy var zipCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "zipcode"
        
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    lazy var zipCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Enter a Zip Code"
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fill
        stView.alignment = UIStackViewAlignment.fill
        stView.spacing   = 8.0
        return stView
    }()
    
    lazy var collectionViewStack: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fill
        stView.alignment = UIStackViewAlignment.fill
        stView.spacing   = 8.0
        return stView
    }()
    
    lazy var zipCodeStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 8.0
        return stView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Search"
        self.zipCodeTextField.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setupSubViews()
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            getWeatherFromOnline(from: zipCode)
        }
        self.zipCodeTextField.becomeFirstResponder()
    }
    
    func getWeatherFromOnline(from zipCode: String) {
        ZipCodeHelper.manager.getLocationName(from: zipCode, completionHandler: {self.nameCityLabel.text = "Weather Forecast for " + $0}, errorHandler: {print($0)})
        WeatherAPIClient.manager.getWeather(from: zipCode, completionHandler: {self.weatherDays = $0}, errorHandler: {print($0)})
        UserDefaultsHelper.manager.save(name: zipCode)
    }
    
}

extension MainWeatherViewController {
    private func setupSubViews(){
        addMainStackViewIntoView()
        mainStackViewConstraints()
        addSubViewsIntoMainStackView()
        addSubViewsIntoSubStackView()
        displayAllSubViews()
    }
    
    private func addMainStackViewIntoView() {
        view.addSubview(mainStackView)
    }
    
    private func mainStackViewConstraints() {
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func addSubViewsIntoMainStackView() {
        mainStackView.addArrangedSubview(nameCityLabel)
        mainStackView.addArrangedSubview(collectionViewStack)
        mainStackView.addArrangedSubview(zipCodeStackView)
        
    }
    
    private func addSubViewsIntoSubStackView() {
        collectionViewStack.addArrangedSubview(collectionView)
        zipCodeStackView.addArrangedSubview(zipCodeTextField)
        zipCodeStackView.addArrangedSubview(zipCodeLabel)
        zipCodeTextField.widthAnchor.constraint(equalTo: zipCodeLabel.widthAnchor).isActive = true
    }
    
    private func displayAllSubViews(){
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionViewStack.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        zipCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
