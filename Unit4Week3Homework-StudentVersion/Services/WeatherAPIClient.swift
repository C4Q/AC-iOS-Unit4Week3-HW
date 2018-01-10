//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

var id = "9USWp4cVqBZB37WLnjMzc"
var secret = "87dY4L6mShGRCMN6W3D3WJAdnG6FRfWr562ClOup"

class WeatherAPIClient {
    private init(){}
    static let manager = WeatherAPIClient()
    
    func getForecast(from urlStr: String,
                     completionHandler: @escaping ([WeatherResponse]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
        //valid url check and pass in zipcode here
        
        guard let url = URL(string: "https://api.aerisapi.com/forecasts/" + urlStr + "client_id=\(id)&client_secret=\(secret)") else {return}
        //internet request using urlStr
        let request = URLRequest(url: url)
        //set completion
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(WeatherResponseWrapper.self, from: data)
                let response = results.response
                
                
                print("JSON Data is now an [SevenDayForecast]")
                
                
                completionHandler(response)
                
            } catch {
                errorHandler(AppError.badData)
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoWeather,
                                              errorHandler: errorHandler)
    }
}
