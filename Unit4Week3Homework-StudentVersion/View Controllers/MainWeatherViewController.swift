//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {
    let weatherView = WeatherView()
    //TODO: format city name before image api call, get array of urls, var randomImg = array[ar4random]
    var cityName = "" {
        didSet{
            weatherView.titleLabel.text = "Weather Forecast for \(cityName)"
            print("city: \(cityName)")
        }
    }
    //data model
    var weatherForecasts = [DailyForecast]() {
        didSet {
            weatherView.collectionView.reloadData()
        }
    }
    
    let cellSpacing: CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.zipTextField.delegate = self
        
        self.title = "Search"
        view.addSubview(weatherView)
        //loadData()
    }
//    func passCity() {
//        let view = WeatherDetailView()
//        view.thisCity = cityName
//    }
    func loadData(zipcode: String) {
        let clientId = "4rkzyfD1kqeSpt9wZ9Py7"
        let clientSecret = "zeAypPfgH6ccGB2Nk5I17blQM4TdusP9qEepLlog"
        let urlStr = "https://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(clientId)&client_secret=\(clientSecret)"
        let completion =  {(onlineWeather: [DailyForecast]) in
            self.weatherForecasts = onlineWeather
            print("starting",self.weatherForecasts, "here")
        }
        AerisAPIClient.manager.getWeather(from: urlStr,
                                                completionHandler: completion,
                                                errorHandler: {print($0, "error getting weather")})
        ZipCodeHelper.manager.getLocationName(from: zipcode, completionHandler: {(self.cityName = $0)}, errorHandler: {print($0)})
    }
    
    //MARK: Sends weatherforecasts object to detail vc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecastInfo = weatherForecasts[indexPath.row]
        let detailVC = WeatherDetailViewController.init(weather: forecastInfo, city: cityName)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension MainWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherForecast = weatherForecasts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        //cell.alpha = 0.1
        let formattedDate = weatherForecast.validTime
        let date = formattedDate.components(separatedBy: "T")
        cell.dateLabel.text = date[0]
        cell.highTempLabel.text = "High: \(weatherForecast.maxTempF)°"
        cell.lowTempLabel.text = "Low: \(weatherForecast.minTempF)°"
        cell.weatherImageView.image = UIImage(named: weatherForecast.icon)
    
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

extension MainWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard !(textField.text?.isEmpty)! else {
            print("empty")
            return true
        }
        if let zipCodeInput = textField.text {
        loadData(zipcode: zipCodeInput)
            
        }
        textField.resignFirstResponder()
    return true
    }
}








