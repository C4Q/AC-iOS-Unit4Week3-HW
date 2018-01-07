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
    
    func getWeather(from str: String,
                    completionHandler: @escaping ([Weather]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: str) else {return}
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
