//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

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
