//
//  WeatherDetailViewController+Extension.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

// MARK:- Functions
extension WeatherDetailViewController {
    
    func fnCityName() {
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            let date = getDateFormatted(from: weather.dateTimeISO, format: "MMM d, yyyy")
            ZipCodeHelper.manager.getLocationName(from: zipCode, completionHandler: {self.nameCityLabel.text = "Weather forecast for \($0) for \(date)"}, errorHandler: {print($0)})
        }
    }
    
    func getDateFormatted(from isoDate: String, format: String) -> String {
        let fromISODate = ISO8601DateFormatter()
        let getStrDateFormatted = DateFormatter()
        getStrDateFormatted.dateFormat = format
        if let dateFromISODate = fromISODate.date(from: isoDate) {
            var stringFromDate = getStrDateFormatted.string(from: dateFromISODate)
            if stringFromDate == getStrDateFormatted.string(from: Date()) && format == "EEEE, d" {
                stringFromDate = "Today"
            }
            return stringFromDate
        }
        return "N/A"
    }
    
    func loadImage() {
        if let zipcode = UserDefaultsHelper.manager.getLastSearch() {
            let complationCityName: (String) -> Void = {(cityName) in
                self.favoriteImage = FavoriteImage(title: cityName, url: "")
                self.cityName = cityName
                self.cityName = cityName.replacingOccurrences(of: " ", with: "+")
                let complationImageURL: (Picture) -> Void = { (onlineImage) in
                    self.favoriteImage.url = onlineImage.imageURL
                    if let cacheImage = NSCacheHelper.manager.getImage(with: onlineImage.imageURL) {
                        self.weatherImageView.image = cacheImage
                        return
                    }
                    WeatherAPIClient.manager.getImage(from: onlineImage.imageURL, completionHandler: {self.weatherImageView.image = $0
                        self.weatherImageView.setNeedsLayout()
                    }, errorHandler: {print($0)})
                }
                WeatherAPIClient.manager.getPicture(cityName: self.cityName, completionHandler: complationImageURL, errorHandler: {print($0)})
            }
            
            ZipCodeHelper.manager.getLocationName(from: zipcode, completionHandler: complationCityName, errorHandler: {print($0)})
        }
    }
}
