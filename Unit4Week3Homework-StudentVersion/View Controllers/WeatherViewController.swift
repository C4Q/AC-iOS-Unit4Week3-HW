//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

/*To Do/Need Help:
 - Figure out autoresizing for favorites and landscape
 - Reset collection view to first cell when new city entered
 - Fix tab bar 
 */

class WeatherViewController: UIViewController {
    
    var twoWeekWeather = [TwoWeekPeriod]() {
        didSet {
            weatherView.weatherCollectionView.reloadData()
        }
    }
    
    var weatherInfo = [TwoWeekPeriod]()
    var cityName: String!
    
    var zipCode: String? = {
        var variable = String()
        if let savedZip = UserDefaultsHelper.manager.getSavedZipCode() {
            variable = savedZip
            print("This is the saved zip from manager: \(variable)")
        }
        return variable
    }()
    
    let weatherView = WeatherView()
    let cellSpacing: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather"
        view.backgroundColor = UIColor.lightGray
        view.addSubview(weatherView)
        weatherView.weatherCollectionView.dataSource = self
        weatherView.weatherCollectionView.delegate = self
        weatherView.weatherTextField.delegate = self
        loadData()
        setUpNameOfCity()
       
        
    }
    
    
    
    func loadData() {
        let urlStr = "https://api.aerisapi.com/forecasts/\(zipCode!)?limit=14&client_id=IlTuJNWbbQr1SoMjKuqNk&client_secret=4MP96kjyzr12iSzdb8p0NHtXXw2bohh7eUV9HtAx"
        guard let url = URL(string: urlStr) else { return }
        print(url)
        let completion: ([TwoWeekPeriod]) -> Void = { (onlineWeather: [TwoWeekPeriod]) in
            self.twoWeekWeather = onlineWeather
        }
        let errorHandler: (Error) -> Void = { (error: Error) in
            print(error.localizedDescription)
        }
        AerisWeatherAPI.manager.getWeather(from: url, completionHandler: completion, errorHandler: errorHandler)
        
        //Loads User Default for zipCode
        if let savedZipCode = UserDefaultsHelper.manager.getSavedZipCode() {
            zipCode = savedZipCode
            print("Loaded User Default: \(savedZipCode)")
        }
    }
    
    
    func setUpNameOfCity() {
        if let savedZipCode = zipCode {
            let completion: (String) -> Void = { (onlineZip: String) in
                print("Here is the zip code used: \(savedZipCode)")
                print("Here is the name: \(onlineZip)")
                self.cityName = onlineZip
                self.weatherView.cityNameLabel.text  = self.cityName
                print(self.cityName)
            }
            let errorHandler: (Error) -> Void = { (error: Error) in
                print(error.localizedDescription)
            }
            ZipCodeHelper.manager.getLocationName(from: savedZipCode , completionHandler: completion, errorHandler: errorHandler)
        }
    }
}


extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if twoWeekWeather.isEmpty {
            return 0
        }
        return twoWeekWeather[0].periods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherThatDay = twoWeekWeather[0].periods[indexPath.row]
        let cell = weatherView.weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as! WeatherViewCell
        
        cell.dateLabel.text = weatherThatDay.dateTimeISO.components(separatedBy: "T")[0]
        cell.weatherImageView.image = UIImage(named: weatherThatDay.icon)
        cell.highLabel.text = "High: \(weatherThatDay.maxTempF.description)"
        cell.lowLabel.text = "Low: \(weatherThatDay.minTempF.description)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let selectedWeather  = twoWeekWeather[0].periods[indexPath.row]
        let destination = WeatherDetailedViewController(fullWeatherDetail: selectedWeather)
        self.navigationController?.pushViewController(destination, animated: true)
        destination.fullWeatherDetail = selectedWeather
        destination.navigationItem.title = cityName
        destination.cityName = cityName
       }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let regex = "[0-9]{1,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userZipCode = textField.text {
            zipCode = userZipCode
            print("Here is the zip code for the text field: \(userZipCode)")
            UserDefaultsHelper.manager.saveNewZipCode(ZipCode: userZipCode)
            print("Zip saved!")
            textField.text = ""
            weatherView.cityNameLabel.text = nil
        }
        
        loadData()
        setUpNameOfCity()
        //        resignFirstResponder()
        
        return true
    }
    
}


extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3.0
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = collectionView.bounds.height
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: (screenHeight - (cellSpacing * 2)))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: 15, bottom: cellSpacing, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

