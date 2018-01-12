//
//  mainViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let cellSpacing: CGFloat = 10
    
    let weatherView = MainWeatherView()
    var cityName = ""
    var sevenDayForcast: WeatherResponse? {
        didSet {
            dump(sevenDayForcast)
            self.weatherView.weatherCollectionView.reloadData()
        }
    }
    
    var zipcode = "" {
        didSet {
            loadWeather(named: zipcode)
        }
    }
    
    
    func loadWeather(named str: String) {
        let setWeather = {(onlineWeather: WeatherResponse) in
            if onlineWeather.success {
                self.sevenDayForcast = onlineWeather
            } else {
                let alertController = UIAlertController(title: "Error Occured", message: "Enter valid Zipcode", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        WeatherAPIClient.manager.getForcast(named: str,
                                            completionHandler: setWeather,
                                            errorHandler: printErrors)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherView)
        view.backgroundColor = UIColor(displayP3Red: 0.1, green: 1, blue: 1, alpha: 1)
        weatherView.weatherCollectionView.dataSource = self
        weatherView.weatherCollectionView.delegate = self
        weatherView.zipTextField.delegate = self
        navigationItem.title = "Search"
        constraintView()
        defaultCity()
        loadWeather(named:"10452")
    }
    
    func defaultCity() {
        ZipCodeHelper.manager.getLocationName(from: "10452",
                                              completionHandler: { self.weatherView.cityLabel.text = "\($0)"},
                                              errorHandler: {print($0)})
    }

    
    func setCityLabel() {
        ZipCodeHelper.manager.getLocationName(from: zipcode,
                                              completionHandler: {self.weatherView.cityLabel.text = "\($0)"; self.cityName=$0},
                                              errorHandler: {print($0)})
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

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (sevenDayForcast?.response.first?.periods.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherView.weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! WeatherCollectionViewCell
        let oneDayForcast = sevenDayForcast!.response[0].periods[indexPath.row]
        cell.dateLabel.text = oneDayForcast.validTime
        cell.imageView.image = UIImage(named: "\(oneDayForcast.icon)")
        cell.maxTempLabel.text = "High: \(oneDayForcast.maxTempF)°F"
        cell.minTempLabel.text = "Low: \(oneDayForcast.minTempF)°F"
    
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedForcast = sevenDayForcast!.response[0].periods[indexPath.row]
        
        let destination = DetailViewController(forcast: selectedForcast, cityName: self.cityName)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       if !(Array(textField.text!).count == 5) {
            let alertController = UIAlertController(title: "Error Occured", message: "Enter valid Zipcode", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else if let zipcode = textField.text {
            self.zipcode = zipcode
        }
        setCityLabel()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
}
