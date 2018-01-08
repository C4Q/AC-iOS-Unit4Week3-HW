//
//  Weather.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct WeatherAllInfo: Codable {
    let response: [Response]
}

struct Response: Codable {
    let periods: [Weather]
}

struct Weather: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempC: Int
    let maxTempF: Int
    let minTempC: Int
    let minTempF: Int
    let avgTempC: Int
    let avgTempF: Int
    let pressureIN: Double
    let weather: String
    let windSpeedMPH: Int
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
}

