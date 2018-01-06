//
//  SearchViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    lazy var nameCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        cv.register(WeatherCVCell, forCellWithReuseIdentifier: "WeatherCell")
        return cv
    }()
    
    lazy var zipCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "zipcode"
        return textField
    }()
    
    lazy var zipCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Enter a Zip Code"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
    }
    
    

}
