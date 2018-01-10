//
//  WeatherModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


//var id = "9USWp4cVqBZB37WLnjMzc"                             ID
//var secret = "87dY4L6mShGRCMN6W3D3WJAdnG6FRfWr562ClOup"      Secret


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
    let currentDateAndTime: String
    let highTempF: Double
    let lowTempF: Double
    let avgTempF: Double
    let rainPrecipIN: Double
    let windSpeedMPH: Double
    let weatherConditions: String // "Mostly Cloudy"
    let weatherIcon: String
    let isTheDayToday : Bool //perfect for date check!
    let sunrise: String
    let sunset: String
    
    enum CodingKeys: String, CodingKey {
        case currentDateAndTime = "validTime"
        case highTempF = "maxTempF"
        case lowTempF = "minTempF"
        case avgTempF
        case rainPrecipIN = "precipIN"
        case windSpeedMPH
        case weatherConditions = "weather"
        case weatherIcon = "icon"
        case isTheDayToday = "isDay"
        case sunrise = "sunriseISO"
        case sunset = "sunsetISO"
    }
}
