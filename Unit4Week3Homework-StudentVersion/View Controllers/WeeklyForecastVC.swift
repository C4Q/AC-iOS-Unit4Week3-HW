//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeeklyForecastVC: UIViewController {
    
    let cellSpacing: CGFloat = 5.0
    let forecastView = WeeklyForecastView()
    var zipcodeSearch: String? {
        didSet {
            loadForecast()
            ZipCodeHelper.manager.getLocationName(from: zipcodeSearch!, completionHandler: {self.forecastView.label.text = "Weekly Forecast for \($0)"}, errorHandler: {print($0)})
        }
    }
    var forecast = [Forecast]() {
        didSet {
            forecastView.collectionView.reloadData()
        }
    }
    
    
    
    
    
    // TODO:
    //    Selecting a collection view cell should segue to a weather detail view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(forecastView)
        
        forecastView.collectionView.delegate = self
        forecastView.collectionView.dataSource = self
        forecastView.textField.delegate = self
        // TODO: Get Data
        if UserDefaultHelper.manager.getZip() != nil {
            loadByUserDefaults()
        } else {
        loadForecast()
        }
    }
    
    
    
    
    
    func loadForecast() {
        //If user defaults is empty start zipcode will be NYC
        //Else start zipcode will be user defaults
        //set up url with key, access code and interpolated zipcode
        let urlStr = "https://api.aerisapi.com/forecasts/\(zipcodeSearch ?? "10465")?client_id=Yc9YCvSnauHy1TLwYolYe&client_secret=x9UHLREb8hGVhxQm2JcuUCIAbsd5CR8F4QmGnjbc"
        //set up a completion handler
        //set up error handler using apperror
        //call forecast API Client
        WeatherAPIClient.manager.getForecast(from: urlStr, completionHandler: {
            UserDefaultHelper.manager.setZip(to: self.zipcodeSearch!)
            self.forecast = $0}, errorHandler: {print($0)})
    }
    
    func loadByUserDefaults() {
        
        let urlStr = "https://api.aerisapi.com/forecasts/\(UserDefaultHelper.manager.getZip() ?? "10465")?client_id=Yc9YCvSnauHy1TLwYolYe&client_secret=x9UHLREb8hGVhxQm2JcuUCIAbsd5CR8F4QmGnjbc"
        //set up a completion handler

        WeatherAPIClient.manager.getForecast(from: urlStr, completionHandler: {self.forecast = $0}, errorHandler: {print($0)})
    }
    
    
}

extension WeeklyForecastVC: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedForecast = forecast[indexPath.row]
        let destination = DetailedVC(forecast: selectedForecast)
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
}

extension WeeklyForecastVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        if !forecast.isEmpty {
            let theForecast = forecast[indexPath.row]
            cell.weatherTypeImage.contentMode = .scaleAspectFit
            cell.dateLabel.text = Date.dateStringFromTimeInterval(timeinterval: TimeInterval(theForecast.timestamp))
            cell.weatherTypeImage.image = UIImage(named: theForecast.icon.replacingOccurrences(of: ".png", with: ""))
            cell.highTempLabel.text = "High: \(theForecast.maxTempF)°F"
            cell.lowTempLabel.text = "Low: \(theForecast.minTempF)°F"
        }
        return cell
    }
    
    
}

extension WeeklyForecastVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.4)
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

extension WeeklyForecastVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 5 {
            zipcodeSearch = textField.text!
            textField.resignFirstResponder()
            return true
        }
        return false
    }

}


