//
//  ForecastAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct WeatherAPIClient{
    private init() {}
    static let manager = WeatherAPIClient()
    func getForecast(from urlStr: String, completionHandler: @escaping ([Forecast]) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let forecastsSearch = try myDecoder.decode(Response.self, from: data)
                completionHandler(forecastsSearch.response[0].periods)
                
            } catch{
                print("Category Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url), completionHandler: completion, errorHandler: errorHandler)
    }
}
