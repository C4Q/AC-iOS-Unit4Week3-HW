//
//  DialogView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Subviews
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 0)
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        return cv
    }()
    
    lazy var collectionImageView: UIImageView = {
        let iv = UIImageView(frame: collectionView.frame)
        return iv
    }()
    
    lazy var zipInputField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red:0.67, green:0.73, blue:0.80, alpha:1.00)
        tf.borderStyle = .roundedRect
//        tf.delegate = self
        tf.textColor = .white
        tf.textAlignment = .center
        tf.autocorrectionType = .no
        tf.placeholder = "Enter a zip code"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var zipLabel: UILabel = {
        let label = UILabel()
        let text = ZipCodeHelper.manager.viewLocationName()
        label.text = text
        return label
    }()
    
    func setLocationLabel() {
        zipLabel.text = ZipCodeHelper.manager.viewLocationName()
    }
    
    lazy var backgroundView: UILabel = {
        let label = UILabel()
        label.center = collectionView.center
        label.font = UIFont(name: "EuphemiaUCAS-Bold", size: 24)
        label.text = "No weather data found. 😎"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Setup
    private func commonInit() {
        setupViews()
    }
    
   
    
    private func setupViews() {
         setupZipLabel()
        setupCollectionView()
        setupZipInputField()
       
        setupCollectionImageView()
    }
    
    func setBackgroundImage(temp: Int) {
        switch temp {
        case ...40:
            self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "coldestDay"))
        case 41...70:
            self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "rainyDay"))
        case 70...:
            self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "sunnyDay"))
        default:
            self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "sunnyDay"))
        }
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.zipLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    private func setupZipInputField() {
        self.addSubview(zipInputField)
        zipInputField.translatesAutoresizingMaskIntoConstraints = false
        zipInputField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true

        zipInputField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        zipInputField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupZipLabel() {
        self.addSubview(zipLabel)
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        zipLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        zipLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupCollectionImageView() {
        collectionView.addSubview(collectionImageView)
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionImageView.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        collectionImageView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        collectionImageView.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
        collectionImageView.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
    }
    
    
}
