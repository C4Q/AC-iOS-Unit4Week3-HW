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
    var zipCode = ""
    var cityName = "" {
        didSet {
            weatherView.cityLabel.text = "Weather forecast in \(cityName)"
        }
    }
    
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
        if let myDefault = UserDefaultHelper.manager.getZipCode() {
            zipCode = myDefault
            weatherView.inputZipCode.text = myDefault
        } else {
            zipCode = "11101"
        }
        getWeatherData()
        getCityName()
        
    }
    
    func getWeatherData() {
        WeatherAPIClient.manager.getWeather(from: zipCode, completionHandler: {self.weatherArray = $0; }, errorHandler: {print($0)})
    }
    func getCityName() {
        ZipCodeHelper.manager.getLocationName(from: zipCode.description, completionHandler: {self.cityName = $0}, errorHandler: {print($0)})
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
        detailVC.cityName = cityName
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                        cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { finished in
                            UIView.animate(withDuration: 0.06, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: { cell!.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: { (_) in
                                self.navigationController?.pushViewController(detailVC, animated: true)
                            } )})

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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowOnlyNumbers = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowOnlyNumbers.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 5 {
            zipCode = textField.text!
            UserDefaultHelper.manager.setZipCode(to: zipCode)
            getWeatherData()
            getCityName()
            textField.resignFirstResponder()
            return true
        }
        return false
    }
}

