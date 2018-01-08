//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
struct WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    private let clientId = "MZdEMiMKjSEIlWV7z95yS"
    private let clientPWD = "njMqfz1ZEAyo41K4GzsIny6jlciY3RCqA3IMhxrC"
    func getWeather(from zipcode: String,
                    completionHandler: @escaping ([Weather]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let urlWeather = "https://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(clientId)&client_secret=\(clientPWD)"
        guard let url = URL(string: urlWeather) else {return}
        let parseDataWeather = {(data: Data) in
            do {
                let onlineWeather = try JSONDecoder().decode(WeatherAllInfo.self, from: data)
                if let getWeather = onlineWeather.response.first {
                    completionHandler(getWeather.periods)
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
}
