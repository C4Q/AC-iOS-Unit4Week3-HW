//
//  MainWeatherViewController+Extension.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

extension MainWeatherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textZipCode = textField.text {
            let urlForcast = "https://api.aerisapi.com/forecasts/\(textZipCode)?client_id=MZdEMiMKjSEIlWV7z95yS&client_secret=njMqfz1ZEAyo41K4GzsIny6jlciY3RCqA3IMhxrC"
            ZipCodeHelper.manager.getLocationName(from: textZipCode, completionHandler: {self.nameCityLabel.text = "Weather Forecast for " + $0}, errorHandler: {print($0)})
            self.getWeatherFromOnline(from: urlForcast)
        }
        self.zipCodeTextField.becomeFirstResponder()
        return true
    }
}

extension MainWeatherViewController: UICollectionViewDelegate {
    
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

extension MainWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weather = self.weatherDays[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? WeatherCVCell {
            let dateFormatterGet = ISO8601DateFormatter()
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "EEEE, d"
            let date = dateFormatterGet.date(from: weather.dateTimeISO)
            var stringFromDate = dateFormatterPrint.string(from: date!)
            if stringFromDate == dateFormatterPrint.string(from: Date()) {
                stringFromDate = "Today"
            }
            cell.dateLabel.text = "\(stringFromDate)"
            cell.weatherImageView.image = UIImage(named: weather.icon)
            cell.highLabel.text = "High: \(weather.maxTempF)ºF"
            cell.lowLabel.text = "Low: \(weather.minTempF)ºF"
            return cell
        }
        return UICollectionViewCell()
    }
}
