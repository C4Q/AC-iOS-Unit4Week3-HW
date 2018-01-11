//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    let cellSpacing: CGFloat = 10
    var zipCode = "10452"
    
    var weatherArray = [Weather]() {
        didSet {
            weatherView.collectionView.reloadData()
        }
    }
    
    let weatherView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherView)
        weatherView.inputZipCode.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.delegate = self
        navigationItem.title = "Search"
        constraintView()
        getWeatherData()
    }
    
    func getWeatherData() {
        WeatherAPIClient.manager.getWeather(from: zipCode, completionHandler: {self.weatherArray = $0}, errorHandler: {print($0)})
    }
    func getCityName() {
        ZipCodeHelper.manager.getLocationName(from: zipCode.description, completionHandler: {self.weatherView.cityLabel.text = "Weather Forecast in \($0)"}, errorHandler: {print($0)})
    }
    
    func constraintView() {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}
extension MainWeatherViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weather = weatherArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.configureWeatherCell(weather: weather)
        return cell
    }
    
}

extension MainWeatherViewController:
UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = WeatherDetailViewController()
        detailVC.weatherObject = weatherArray[indexPath.row]
        detailVC.cityName = weatherView.cityLabel.text
        //TODO add extra descriptions
        navigationController?.pushViewController(detailVC, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text?.description {
        zipCode = text
        }
        getWeatherData()
        getCityName()
        print("return")
        return true
    }
}

