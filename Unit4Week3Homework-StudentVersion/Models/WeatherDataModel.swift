//
//  WeatherDataModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    enum SavingDataResults: String {
        case exists = "Already favorited"
        case success = "Favorite Saved"
        case error = "Bad data"
        case removed = "Removed from favorites"
    }
    
    private init() {}
    static let manager = WeatherDataModel()
    private let defaultZipCode = "11103"
    private static let kPathname = "WeatherForecast.plist"
    
    private var cityName: String = ""
    private var zipcode: String = ""
    private var savedForecast: Weather? {
        didSet {
            print(savedForecast ?? "no data")
        }
    }
    
    func getForecast(for index: Int) -> Details? {
        
        guard let savedForecast = savedForecast else { return nil }
        return savedForecast.response.first?.periods[index]
    }
    
    func getZipCode() -> String {
        return zipcode
    }
    
    func getCityName() -> String {
        return cityName
    }
    
    func setDefaultForecast() {
        guard savedForecast == nil else { return }
        searchForForecast(by: defaultZipCode)
    }
    
    func getForecastCount() -> Int {
        guard let daysForecasted = savedForecast?.response.first?.periods.count else { return 0 }
        return daysForecasted
    }
    
    func searchForForecast(by location: String) {
        self.zipcode = location
        WeatherAPIClient.manager.getForecast(for: location, completion: { self.savedForecast = $0 }, errorHandler: { print($0) })
        ZipCodeHelper.manager.getLocationName(from: location, completionHandler: { self.cityName = $0 }, errorHandler: { print($0) })
    }
}

