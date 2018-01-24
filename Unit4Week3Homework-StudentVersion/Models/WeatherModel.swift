//
//  WeatherModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

//key: x9UHLREb8hGVhxQm2JcuUCIAbsd5CR8F4QmGnjbc
//Access ID: Yc9YCvSnauHy1TLwYolYe




struct Response: Codable {
    let response: [Periods]
}

struct Periods: Codable {
    let periods: [Forecast]
}

struct Forecast: Codable {
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
