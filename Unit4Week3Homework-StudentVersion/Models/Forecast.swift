//
//  Forecast.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


struct ForecastSearch: Codable{
    let response: [SearchResults]
}

struct SearchResults: Codable {
    let periods: [Forecast]
}

struct Forecast: Codable{
    let timestamp: Int
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let windSpeedMPH: Int
    let weather: String
    let icon: String
    let sunrise: Int
    let sunset: Int
}

