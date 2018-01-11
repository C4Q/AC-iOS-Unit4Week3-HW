//
//  DataModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

//protocol DataModelDelegate: class {
//    func update(_ image: UIImage?, photo: Photo)
//}

class DataModel {
    
    enum SavingDataResults: String {
        case exists = "Already favorited"
        case success = "Favorite Saved"
        case error = "Bad data"
        case removed = "Removed from favorites"
    }
    
    //weak var delegate: PhotoDataModelDelegate?
    private init() {}
    static let manager = DataModel()
    
    private static let kPathname = "WeatherForecast.plist"
    
    private var cityName: String = ""
    private var savedForecast: [Forecast]? {
        didSet {
            print(savedForecast ?? "no data")
            UserDefaultsHelper.manager.set(to: cityName.description)
        }
    }
    
    func getForecast() -> [Forecast]? {
        guard let savedForecast = savedForecast else { return nil }
        return savedForecast
    }
    
    func searchForForecast(by location: String) {
        WeatherAPIClient.manager.getForecast(for: location, completion: { self.savedForecast = $0 }, errorHandler: { print($0) })
        ZipCodeHelper.manager.getLocationName(from: location, completionHandler: { self.cityName = $0}, errorHandler: { print($0) })
    }
    
//    func setProfile(image: UIImage?, photo: Photo) {
//        // 3 setting the delegate
//        delegate?.didUpdateProfile(image, photo: photo)
//    }
    
}

