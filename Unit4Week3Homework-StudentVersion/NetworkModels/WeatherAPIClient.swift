//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class WeatherAPIClient {
    private init(){}
    static let manager = WeatherAPIClient()
    
    func getForecast(from urlStr: String,
                     completionHandler: @escaping ([WeatherResponse]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
        //valid url check
        guard let url = URL(string: urlStr) else {return}
        //internet request using urlStr
        let request = URLRequest(url: url)
        //set completion
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(WeatherResponse.self, from: data)
                let forecast = results.periods
                print("JSON Data is now an [SevenDayForecast]")
                
                for weather in forecast{
                    print(weather.highTempF, weather.lowTempF)
                }
                
            } catch {
                errorHandler(AppError.badData)
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoWeather,
                                              errorHandler: errorHandler)
    }
}
