//
//  Weather.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct FavoriteImage: Codable {
    var title: String
    var url: String
}

struct WeatherAllInfo: Codable {
    let allInfo: [Response]
    
    enum CodingKeys: String, CodingKey {
        case allInfo = "response"
    }
}

struct Response: Codable {
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case weather = "periods"
    }
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

struct AllPictures: Codable {
    let picture: [Picture]?
    
    enum CodingKeys: String, CodingKey {
        case picture = "hits"
    }
}

struct Picture: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "webformatURL"
    }
}

