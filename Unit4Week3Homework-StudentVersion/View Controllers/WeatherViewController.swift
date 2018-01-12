//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        commonInit()
        WeatherDataModel.manager.delegate = self
    }
    
    //TODO:
    //PUBLIC APIs
    // Private implementations
    
    let cellSpacing: CGFloat = 5.0
    let numberOfCells: CGFloat = 3
    
    let cellId = "WeatherCollectionViewCell"
    
    //MARK: - Outlets
    lazy var cityLabel: UILabel = {
        let label = UILabel() // instantiating
        label.text = "Weather forecast for New York"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var searchField: UITextField = {
        let textfield = UITextField() // instantiating
        textfield.placeholder = "Zip Code"
        textfield.textAlignment = .center
        textfield.delegate = self
        textfield.keyboardAppearance = .light
        textfield.returnKeyType = .search
        return textfield
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var zipCodeLabel: UILabel = {
        let label = UILabel() // instantiating
        label.text = "Enter a Zip Code"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private func commonInit() {
        addSubview()
        setupViews()
        WeatherDataModel.manager.setDefaultForecast()
    }
    
    func addSubview() {
        self.view.addSubview(cityLabel)
        self.view.addSubview(weatherCollectionView)
        self.view.addSubview(searchField)
        self.view.addSubview(zipCodeLabel)
    }
    
    private func setupViews() {
        setupCityLabel()
        setupWeatherCollectionView()
        setupSearchField()
        setupZipCodeLabel()
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        WeatherDataModel.manager.searchForForecast(by: text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil{
            let length = (textField.text?.count)! + string.count
            if length <= 5 {
                return true
            }
        }
        return false
    }
}
    
    extension WeatherViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return WeatherDataModel.manager.getForecastCount()
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherCollectionViewCell
            let index = indexPath.row
            guard WeatherDataModel.manager.getForecastCount() != 1 else {
                cell.dateLabel.text = "No Data"
                cell.weatherGraphic.image = nil
                cell.highTempLabel.text = "at this time."
                return cell
            }
            guard let details = WeatherDataModel.manager.getForecast(for: index) else { return cell }
            cell.configureCell(with: details )
            return cell
        }
    }
    
    extension WeatherViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numSpaces: CGFloat = numberOfCells + 1
            
            let weatherCollectionViewWidth = collectionView.bounds.width
            let weatherCollectionViewwHeight = collectionView.bounds.height
            
            return CGSize(width: (weatherCollectionViewWidth - (cellSpacing * numSpaces)) / (numberOfCells + 0.3), height: weatherCollectionViewwHeight * 0.90)
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
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let index = indexPath.row
            let destination = DetailViewController(forecast: WeatherDataModel.manager.getForecast(for: index)!)
            self.navigationController?.pushViewController(destination, animated: true)
        }
        
    }
    
    
    //MARK: -Constraints
    extension WeatherViewController {
        
        private func setupCityLabel() {
            let safeArea = view.safeAreaLayoutGuide
            cityLabel.translatesAutoresizingMaskIntoConstraints = false
            cityLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 11).isActive = true
            cityLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            cityLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            
        }
        
        private func setupWeatherCollectionView() {
            let safeArea = view.safeAreaLayoutGuide
            weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
            weatherCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20).isActive = true
            weatherCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
            weatherCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
            weatherCollectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.35).isActive = true
        }
        
        private func setupSearchField() {
            let safeArea = view.safeAreaLayoutGuide
            searchField.translatesAutoresizingMaskIntoConstraints = false
            searchField.backgroundColor = UIColor.lightGray
            searchField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 12).isActive = true
            searchField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0).isActive = true
            searchField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.04).isActive = true
            searchField.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.50).isActive = true
        }
        
        private func setupZipCodeLabel() {
            let safeArea = view.safeAreaLayoutGuide
            zipCodeLabel.backgroundColor = .white
            zipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
            zipCodeLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 15).isActive = true
            zipCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            zipCodeLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.50).isActive = true
        }
        
    }
    
    extension WeatherViewController: WeatherDataModelForecastDetailsDelegate {
        func loadForecast() {
            weatherCollectionView.reloadData()
        }
        func loadCityName() {
            cityLabel.text = "Weather forecast for \(WeatherDataModel.manager.getCityName())"
        }
}


