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
    
    func getForecast(for zipcode: String,
                     completionHandler: @escaping ([SevenDayForecast]) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
        //valid url check and pass in zipcode here
        
        guard let url = URL(string: "https://api.aerisapi.com/forecasts/" + zipcode + "?client_id=\(id)&client_secret=\(secret)") else {return}
        //internet request using urlStr
        let request = URLRequest(url: url)
        //set completion
        let parseDataIntoWeather: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherResponseWrapper.self, from: data)
                if let results = response.response.first?.periods {
                    completionHandler(results)
                }
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoWeather,
                                              errorHandler: errorHandler)
    }
}
