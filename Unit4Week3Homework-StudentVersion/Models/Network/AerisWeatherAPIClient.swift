//
//  AerisWeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/7/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class AerisWeatherAPIClient {
    
    private init() {}
    static let manager = AerisWeatherAPIClient()
    
    fileprivate let appID = "TOr0joXUTRXehQC65H1Rh"
    fileprivate let secretKey = "EGckPv8PcclD8tdyRGzhBQUbBMznAVyWVHskCWEe"
    
    //https://api.aerisapi.com/[:endpoint]/[:action]?client_id=[ID]&client_secret=[SECRET]
    ///forecasts/55415?
    
    func getForecast(zip: String,
                     completionHandler: @escaping ([Forecast]) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        
        let endpoint = "https://api.aerisapi.com/forecasts/\(zip)?client_id=\(appID)&client_secret=\(secretKey)"
        
        guard let url = URL(string: endpoint) else { errorHandler(AppError.badUrl); return }
        
        let request = URLRequest(url: url)
        
        let completion: (Data) -> Void = { (data: Data) in
            
            do {
                let json = try JSONDecoder().decode(AerisWeatherResults.self, from: data)
                if !json.response.isEmpty {
                    completionHandler(json.response[0].periods)
                } else {
                    errorHandler(AppError.badJSON)
                }
            } catch {
                errorHandler(AppError.codingError(rawError: error))
                
            }
            
            
        }
        
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
        
        
    }

    
    
    
    
    
}


