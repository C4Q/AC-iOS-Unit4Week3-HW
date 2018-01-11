//
//  Weather.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Weather: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let sunriseISO: String
    let sunsetISO: String
    let icon: String
    let precipMM: Double
    let precipIN: Double
    let feelslikeF: Int
    let weather: String
    let windSpeedMPH: Int
}

struct LongLat: Codable {
    let long: Double
    let lat: Double
}


struct TwoWeekPeriod: Codable {
    let periods: [Weather]
    let loc: LongLat
}

struct AerisWeather: Codable {
    let response: [TwoWeekPeriod]
    let success: Bool
}


struct AerisWeatherAPI {
    private init() {}
    static let manager = AerisWeatherAPI()
    func getWeather(from url: URL, completionHandler: @escaping ([TwoWeekPeriod]) -> Void, errorHandler: @escaping (Error) -> Void) {
        print("Started manager")
        let urlRequest = URLRequest(url: url)
        print("Did request")
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let onlineWeather = try JSONDecoder().decode( AerisWeather.self, from: data)
                let result = onlineWeather.response
                print("This is the result count!")
                print(result.count)
                completionHandler(result)
            }
            catch {
                errorHandler(error)
            }
            
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
