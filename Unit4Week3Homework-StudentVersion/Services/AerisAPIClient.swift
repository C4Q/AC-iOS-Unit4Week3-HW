//
//  AerisAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Weather: Codable {
    let response: [WeatherWrapper]
}

struct WeatherWrapper: Codable {
    let loc: LocationWrapper
    let periods: [DailyForecast]
}

struct LocationWrapper: Codable {
    let long: Double
    let lat: Double
}

struct DailyForecast: Codable {
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let weather: String
    let sunriseISO: String
    let sunsetISO: String
    let precipIN: Double
    let icon: String
}
//TODO: Fin API Client
struct AerisAPIClient {
    private init() {}
    static let manager = AerisAPIClient()
    func getWeather(from urlStr: String, completionHandler: @escaping ([DailyForecast]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else  {return}
        let request = URLRequest(url:url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let allResults = try JSONDecoder().decode(Weather.self, from: data)
                let allWeather = allResults.response
                if let weather = allWeather.first?.periods {
                    completionHandler(weather)
                }else{
                    errorHandler(AppError.noData)
                }
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
}


//https://api.aerisapi.com/forecasts/11220?client_id=4rkzyfD1kqeSpt9wZ9Py7&client_secret=zeAypPfgH6ccGB2Nk5I17blQM4TdusP9qEepLlog
