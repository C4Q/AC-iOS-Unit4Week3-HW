//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    //var forcast = [Forcast]()
    
    var weatherView = WeatherView()
    
    var zipcode = "" {
        didSet {
            //does stuff
        }
    }
    
    var cellSpacing: CGFloat = 5.0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherView)
        weatherView.zipCodeInput.delegate = self
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        configureNavBar()
        makeNavBarButton()
    }
    
    func makeNavBarButton() {
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(action))
    }
    
    @objc func action() {
        
    }
    
    private func configureNavBar() {
        navigationItem.title = "Weather"
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if "0123456789".contains(string) || string == "" {
            return true
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let zipcode = textField.text else {
            return false
        }
        
        self.zipcode = zipcode
        weatherView.zipCodeInput.resignFirstResponder()
        return true
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherView.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .orange
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / (numCells + 0.3), height: screenHeight * 0.28)
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
