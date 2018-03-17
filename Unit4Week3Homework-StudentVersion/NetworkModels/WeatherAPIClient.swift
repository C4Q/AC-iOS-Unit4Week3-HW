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
    
    func getForecast(fromString urlStr: String,
                     completionHandler: @escaping ([SevenDayForecast]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
        guard let url = URL(string: urlStr) else {return}
        
        let request = URLRequest(url: url)
        
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(WeatherResponseWrapper.self, from: data)
                if let forecast = results.response.first?.periods{
                    completionHandler(forecast)
                }
                //print("JSON Data is now an [WeatherResponse]")
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
    
    
    
    func getForecast(usingZipCode zipCode: String, completion: @escaping ([SevenDayForecast]) -> Void, errorHandler: @escaping (Error) -> Void){
        guard let formattedZip = zipCode.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {print("zipcode not formatted correctly");return}
        
        let endPoint = "https://api.aerisapi.com/forecasts/\(formattedZip)?client_id=\(APIKeys.weatherClientID)&client_secret=\(APIKeys.weatherSecretKey)"
        
        guard let url = URL(string: endPoint) else {print("not a valid url"); return}
        
        let request = URLRequest(url: url)
        
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(WeatherResponseWrapper.self, from: data) //top layer
                if let forecast = results.response.first?.periods{ //[SevenDayResponse]
                    completion(forecast)
                }
                //print("JSON Data is now an [WeatherResponse]")
            } catch {
                print("error:\(AppError.badData)")
                print("bad data from weather")
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoWeather,
                                              errorHandler: {print($0)})
    }

