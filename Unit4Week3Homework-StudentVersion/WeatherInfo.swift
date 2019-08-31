//
//  WeatherInfo.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
struct WeatherInfo: Codable {
    let response: [InfoDict] // arr[0]
}
struct InfoDict: Codable {
    let periods: [DayWeather] // 7 days' weather
    let profile: CityDict
}
struct CityDict: Codable {
    let tz: String // "America/Chicago"
}
struct DayWeather: Codable {
    let validTime: String // "2018-01-11T07:00:00-06:00"
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let windSpeed80mMPH: Int
   // let avgTempF: Int
   // let uvi: Int
    //let maxHumidity: Int
   // let minHumidity: Int
   // let humidity: Int
    let weather: String // "Mostly Cloudy with Light Snow"
    let weatherPrimary: String // "Light Snow"
    let icon: String //  "mcloudys.png"
    let sunriseISO: String // "2018-01-11T07:49:04-06:00"
    let sunsetISO: String 
    
}
