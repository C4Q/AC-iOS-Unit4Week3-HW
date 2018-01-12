//
//  Forecast.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct AerisWeatherResults: Codable {
    let response: [Response]
}

struct Response: Codable {
    let periods: [Forecast]
}

struct Forecast: Codable {
    let timestamp: Int //1515326400,
    let validTime: String //"2018-01-07T07:00:00-05:00",
    let dateTimeISO: String //"2018-01-07T07:00:00-05:00",
    let maxTempC: Int //-8,
    let maxTempF: Int //18,
    let minTempC: Int //-8,
    let minTempF: Int //17,
    let avgTempC: Int //-8,
    let avgTempF: Int //17,
    let precipMM: Double //0,
    let precipIN: Double //0,
    let snowCM: Double //0,
    let snowIN: Double //0,
    let feelslikeC: Int //-23,
    let feelslikeF: Int //-9,
    let minFeelslikeC: Int //-23,
    let minFeelslikeF: Int //-9,
    let maxFeelslikeC: Int //-14,
    let maxFeelslikeF: Int //7,
    let avgFeelslikeC: Int //-17,
    let avgFeelslikeF: Int //1,
    let windSpeedKTS: Int //8,
    let windSpeedKPH: Int //15,
    let windSpeedMPH: Int //9,
    let weather: String //"Mostly Sunny",
    let weatherPrimary: String //"Mostly Sunny",
    var icon: String
    let sunrise: Int //1515327542
    let sunriseISO: String //"2018-01-07T07:19:02-05:00",
    let sunset: Int //1515361481,
    let sunsetISO: String //"2018-01-07T16:44:41-05:00"
}
