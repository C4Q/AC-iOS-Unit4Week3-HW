//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
struct WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    private let clientId = "MZdEMiMKjSEIlWV7z95yS"
    private let clientPWD = "njMqfz1ZEAyo41K4GzsIny6jlciY3RCqA3IMhxrC"
    private let keyAPI = "7289838-6524802df66f4e533b2412098"
    func getWeather(from zipcode: String,
                    completionHandler: @escaping ([Weather]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let urlWeather = "https://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(clientId)&client_secret=\(clientPWD)"
        guard let url = URL(string: urlWeather) else {return}
        let parseDataWeather = {(data: Data) in
            do {
                let onlineWeather = try JSONDecoder().decode(WeatherAllInfo.self, from: data)
                if let getWeather = onlineWeather.allInfo.first {
                    completionHandler(getWeather.weather)
                } else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataWeather, errorHandler: errorHandler)
    }
    
    func getPicture(cityName: String,
                    completionHandler: @escaping (Picture) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let urlWeather = "https://pixabay.com/api/?key=\(keyAPI)&q=\(cityName)&image_type=photo&category=places"
        guard let url = URL(string: urlWeather) else {return}
        let parseDataWeather = {(data: Data) in
            do {
                let onlinePicture = try JSONDecoder().decode(AllPictures.self, from: data)
                if let getPicture = onlinePicture.picture {
                    let rndIndex = Int(arc4random() % UInt32(getPicture.count))
                    completionHandler(getPicture[rndIndex])
                } else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataWeather, errorHandler: errorHandler)
    }
    
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        if let cacheImage = NSCacheHelper.manager.getImage(with: urlStr) {
            completionHandler(cacheImage)
            return
        }
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.notAnImage)
                return
            }
            completionHandler(onlineImage)
            NSCacheHelper.manager.addImage(with: urlStr, and: onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
