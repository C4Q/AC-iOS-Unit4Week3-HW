//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
   
    let cellSpacing: CGFloat = 15.0
    
    lazy var titleLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        //nameLabel.text = "PlaceHolder Text"
        return nameLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCell")
        cv.backgroundColor = .red
        return cv
    }()
    
    lazy var zipTextField: UITextField = {
        let zipTextField = UITextField()
        zipTextField.placeholder = "Enter Zipcode Here"
        zipTextField.backgroundColor = .gray
        zipTextField.textAlignment = .center
        return zipTextField
    }()
    
    lazy var enterZipLabel: UILabel = {
        let enterZipLabel = UILabel()
        enterZipLabel.textAlignment = .center
        enterZipLabel.text = "Enter a Zip Code"
        return enterZipLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
        self.title = "Search"
        setupViews()
    }
    
    func setupViews() {
        setupNameLabel()
        setupCollectionView()
        setupZipTextField()
        setupEnterZipLabel()
    }
    
    func setupNameLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    
    func setupZipTextField() {
        view.addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        zipTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        zipTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zipTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupEnterZipLabel() {
        view.addSubview(titleLabel)
        enterZipLabel.translatesAutoresizingMaskIntoConstraints = false
        enterZipLabel.topAnchor.constraint(equalTo: zipTextField.bottomAnchor).isActive = true
        enterZipLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        enterZipLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension MainWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension MainWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
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









