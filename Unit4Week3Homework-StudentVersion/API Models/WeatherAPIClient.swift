//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct WeatherTopInfo: Codable {
    let response: [WeatherInfo]?
}
struct WeatherInfo: Codable {
    let periods: [Weather]
}
struct Weather: Codable {
    let icon: String
    let weather: String
    let timestamp: Int
    let maxTempF: Int
    let minTempF: Int
    let sunrise: Int
    let sunset: Int
    let windSpeedMPH: Int
    let precipIN: Double
}
class WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    func getWeather(from zipCode: String, completionHandler: @escaping ([Weather]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let keyRing = (ID:"N0dZaaXwh0PblSJvu4LX9", Secret:"iNtBe4gyVZ4n3hX8XY8CmZRkuebOYr8q2v2TS3H7")
        guard let url = URL(string:"https://api.aerisapi.com/forecasts/\(zipCode)?client_id=\(keyRing.ID)&client_secret=\(keyRing.Secret)") else {return}
        let request = URLRequest(url: url)
        let weatherData: (Data) -> Void = {(data) in
            do {
                let result = try JSONDecoder().decode(WeatherTopInfo.self, from: data)
                if let response = result.response?.first?.periods {
                completionHandler(response)
                }
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: weatherData , errorHandler: errorHandler)
    }
}

