//
//  WeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var twoWeekWeather = [TwoWeekPeriod]() {
        didSet {
            weatherView.weatherCollectionView.reloadData()
        }
    }
    
    var zipCode: String? = {
        var variable = String()
        if let savedZip = UserDefaultsHelper.manager.getSavedZipCode() {
            variable = savedZip
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
        
    }
    
    
    func loadData() {
        let urlStr = "https://api.aerisapi.com/forecasts/\(zipCode!)?limit=14&client_id=IlTuJNWbbQr1SoMjKuqNk&client_secret=4MP96kjyzr12iSzdb8p0NHtXXw2bohh7eUV9HtAx"
        guard let url = URL(string: urlStr) else { return }
        print(url)
        let completion: ([TwoWeekPeriod]) -> Void = { (onlineWeather: [TwoWeekPeriod]) in
            print(onlineWeather)
            print("Count starts here!!!!")
            print(onlineWeather.count)
            self.twoWeekWeather = onlineWeather
        }
        let errorHandler: (Error) -> Void = { (error: Error) in
            print(error.localizedDescription)
        }
        AerisWeatherAPI.manager.getWeather(from: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    func setUpNameOfCity() {

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
        cell.dateLabel.text = weatherThatDay.dateTimeISO
        cell.weatherImageView.image = UIImage(named: weatherThatDay.icon)
        cell.highLabel.text = "High: \(weatherThatDay.maxTempF.description)"
        cell.lowLabel.text = "Low: \(weatherThatDay.minTempF.description)"
        
        return cell
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
            UserDefaultsHelper.manager.saveNewZipCode(ZipCode: userZipCode)
            zipCode = userZipCode
            print("Zip saved!")
            textField.text = ""
            weatherView.cityNameLabel.text = nil
        }
        loadData()
        resignFirstResponder()
        
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

