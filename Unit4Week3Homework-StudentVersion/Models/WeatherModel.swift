//
//  WeatherModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


struct WeatherResponseWrapper: Codable {
    let response: [WeatherResponse]
}

struct WeatherResponse: Codable {
    let location: CoordinateWrapper
    let periods: [SevenDayForecast] //gives stats for each of the seven days
    
    enum CodingKeys: String, CodingKey {
        case location = "loc"
        case periods = "periods"
    }
}

struct CoordinateWrapper: Codable {
    let long: Double
    let lat: Double
}

struct SevenDayForecast : Codable {
    let timeStamp: Double
    let highTempF: Int
    let lowTempF: Int
    let avgTempF: Double
    let rainPrecipIN: Double
    let windSpeedMPH: Double
    let weatherConditions: String // "Mostly Cloudy"
    let weatherIcon: String
    let isTheDayToday : Bool //perfect for date check!
    let sunrise: Double
    let sunset: Double
    
    enum CodingKeys: String, CodingKey {
        case timeStamp = "timestamp"
        case highTempF = "maxTempF"
        case lowTempF = "minTempF"
        case avgTempF
        case rainPrecipIN = "precipIN"
        case windSpeedMPH
        case weatherConditions = "weather"
        case weatherIcon = "icon"
        case isTheDayToday = "isDay"
        case sunrise
        case sunset
    }
}


