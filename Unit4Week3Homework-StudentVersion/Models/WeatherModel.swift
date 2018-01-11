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


/*
 Forecast Weekly:
 validTime : String
 maxTempF : Int
 minTempF : Int
 
 
 DetailedVC:
 maxTempF : Int
 minTempF : Int
 sunriseISO : String
 sunsetISO : String
 windSpeedMPH : Int
 precipIN : Int
 
 */


struct Response: Codable {
    let response: [Periods]
}

struct Periods: Codable {
    let periods: [Forecast]
}

struct Forecast: Codable {
    let validTime: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let windSpeedMPH: Int
    let weather: String
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
    
}
