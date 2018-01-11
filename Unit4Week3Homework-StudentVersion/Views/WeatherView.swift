//
//  WeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    let cellId = "WeatherCollectionViewCell"
    let cellSpacing: CGFloat = 2.0
    let numberOfCells: CGFloat = 3
    
//    var weatherForecast: [Forecast] = [] {
//        didSet {
//            weatherCollectionView.reloadData()
//        }
//    }
    
    //MARK: - Outlets
    lazy var cityLabel: UILabel = {
        let label = UILabel() // instantiating
        label.text = "Weather forecast for New York"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchField: UITextField = {
        let textFeld = UITextField() // instantiating
        textFeld.text = "Enter a zipcode"
        textFeld.textAlignment = .center
        return textFeld
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var zipCodeLabel: UILabel = {
        let label = UILabel() // instantiating
        label.text = "Enter a Zip Code"
        label.textAlignment = .center
        return label
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
        backgroundColor = .purple
        setupViews()
    }
    
    private func setupViews() {
        setupCityLabel()
        setupWeatherCollectionView()
        setupSearchField()
        setupZipCodeLabel()
    }
    
}

//extension WeatherView: UITextFieldDelegate {

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        guard let text = textField.text else { return false }
//        WeatherAPIClient.manager.getForecast(for: text, completion: { self.weatherForecast = $0 }, errorHandler: { print($0) })
//        return true
//    }
//}

extension WeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //weatherForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherCollectionViewCell
//        cell.dateLabel.text = weatherForecast[0].periods[indexPath.row].dateTimeIso
        cell.backgroundColor = .orange
        return cell
    }
}

extension WeatherView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numSpaces: CGFloat = numberOfCells + 1
        
        let weatherCollectionViewWidth = collectionView.bounds.width
        let weatherCollectionViewwHeight = collectionView.bounds.height
        
        return CGSize(width: (weatherCollectionViewWidth - (cellSpacing * numSpaces)) / numberOfCells, height: weatherCollectionViewwHeight * 0.25)
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


//MARK: -Constraints
extension WeatherView {
    
    private func setupCityLabel() {
        addSubview(cityLabel)
        let safeArea = safeAreaLayoutGuide
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 11).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
    }
    
    private func setupWeatherCollectionView() {
        addSubview(weatherCollectionView)
        let safeArea = safeAreaLayoutGuide
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setupSearchField() {
        addSubview(searchField)
        let safeArea = safeAreaLayoutGuide
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.backgroundColor = .white
        searchField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 12).isActive = true
        searchField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0).isActive = true
        searchField.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.05).isActive = true
        searchField.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.50).isActive = true
    }
    
    private func setupZipCodeLabel() {
        addSubview(zipCodeLabel)
        let safeArea = safeAreaLayoutGuide
        zipCodeLabel.backgroundColor = .white
        zipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        zipCodeLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 15).isActive = true
        zipCodeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        zipCodeLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.50).isActive = true
    }
    
}






