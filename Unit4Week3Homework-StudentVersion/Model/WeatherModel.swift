//
//  WeatherModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class WeatherModel {
    private init() {}
    static let manager = WeatherModel()
    
    private var zipCode: String?
    
    private var weatherData: Weather?
    
    func getWeatherData() -> Weather? {
        return weatherData
    }
    
    func setZipCode(zip: String) {
        zipCode = zip
    }
    
    func getZipCode() -> String? {
        return zipCode
    }
    
    func weatherEndpointFromZipCode(_ zipCode: String?) -> String? {
        guard let zipCode = zipCode else { return nil }
        
        var endpoint = URLComponents(string: "https://api.aerisapi.com/forecasts/\(zipCode)")
        endpoint?.queryItems = [
            URLQueryItem(name: "client_id", value: "4TrQgLECYWUSFoL0EZIjL"),
            URLQueryItem(name: "client_secret", value: "QQzbq5bvl5pPR5DG81LkwyuNmdUK3kFzHnruexkA")
        ]
        
        guard let weatherEndpoint = endpoint?.url?.absoluteString else { return nil }
        return weatherEndpoint
    }
}

struct Weather: Codable {
    let response: [Response]
    let success: Bool
}

struct Response: Codable {
    let loc: LOC
    let interval: String
    let periods: [Period]
    let profile: Profile
}

struct LOC: Codable {
    let long, lat: Double
}

struct Period: Codable {
    let timestamp: Int
    let validTime, dateTimeISO: String
    let maxTempC, maxTempF, minTempC, minTempF: Int
    let avgTempC, avgTempF: Int
    let pop: Int
    let precipMM, precipIN: Double
    let sky: Int
    let weather: String
    let weatherCoded: [WeatherCoded]
    let weatherPrimary, weatherPrimaryCoded, cloudsCoded, icon: String
    let windSpeed80mMPH, windSpeedMax80mMPH, windSpeedMin80mMPH: Int
    let isDay: Bool
    let sunrise: Int
    let sunriseISO: String
    let sunset: Int
    let sunsetISO: String
}

struct WeatherCoded: Codable {
    let timestamp: Int
    let wx, dateTimeISO: String
}

struct Profile: Codable {
    let tz: String
}
