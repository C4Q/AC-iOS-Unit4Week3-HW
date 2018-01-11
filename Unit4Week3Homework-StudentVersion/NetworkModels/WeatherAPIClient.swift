//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


//struct WeatherResponseWrapper: Codable {
//    let response: [WeatherResponse]
//}
//
//struct WeatherResponse: Codable {
//    let location: CoordinateWrapper
//    let periods: [SevenDayForecast] //gives stats for each of the seven days
//
//    enum CodingKeys: String, CodingKey {
//        case location = "loc"
//        case periods = "periods"
//    }
//}
//
//struct CoordinateWrapper: Codable {
//    let long: Double
//    let lat: Double
//}
//
//struct SevenDayForecast : Codable {
//    let currentDateAndTime: String
//    let highTempF: Double
//    let lowTempF: Double
//    let avgTempF: Double
//    let rainPrecipIN: Double
//    let windSpeedMPH: Double
//    let weatherConditions: String // "Mostly Cloudy"
//    let weatherIcon: String
//    let isTheDayToday : Bool //perfect for date check!
//    let sunrise: String
//    let sunset: String
//}


class WeatherAPIClient {
    private init(){}
    static let manager = WeatherAPIClient()
    
    func getForecast(from urlStr: String,
                     completionHandler: @escaping ([SevenDayForecast]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
        //valid url check
        guard let url = URL(string: urlStr) else {return}
        //internet request using urlStr
        let request = URLRequest(url: url)
        //set completion
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(WeatherResponseWrapper.self, from: data) // when you decode the top layer you see what's inside.
                if let forecast = results.response.first?.periods{ //[SevenDayResponse]
                //call completionHandler ON the forecast
                    completionHandler(forecast)
                }
                
                print("JSON Data is now an [WeatherResponse]")
                
            } catch {
                errorHandler(AppError.badData)
                print("bad data from weather")
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoWeather,
                                              errorHandler: errorHandler)
    }
}
