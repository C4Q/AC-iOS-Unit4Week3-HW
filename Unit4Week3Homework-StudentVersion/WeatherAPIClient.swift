//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let success: Bool
    let response: [WeatherPeriod]
}

struct WeatherPeriod: Codable {
    let periods: [WeatherInfo]

}

struct WeatherInfo: Codable {
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
//    sunrise": 1515592168
    let icon: String
//   "weatherPrimary": "Cloudy",
//    "sunriseISO": "2018-01-10T07:49:28-06:00",
//    "sunset": 1515624737,
//    "sunsetISO": "2018-01-10T16:52:17-06:00"
}


struct Favorite: Codable {
    let cityName: String
}




class WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    func getForcast(named searchStr: String,
                    completionHandler: @escaping (WeatherResponse) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let accessID = "4RYBtvJuYBFGKbtlZbKV2"
        let secretKey = "Ukmfo1nE1bbJcp9bxQrrwybO3MXBNgBXvAQ2643L"
        
        let urlStr = "https://api.aerisapi.com/forecasts/\(searchStr)?client_id=\(accessID)&client_secret=\(secretKey)"

        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completionHandler(weatherResponse)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
