//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

/*
 We have set you up with a demo project so you can start using our APIs immediately. Just use the following access keys when making requests:
 
 Access ID
 1krHhkxLdoql0xYggtUB4
 
 Secret Key
 7BZndrbuPuS1o8S0OEarpVsn0FMW3bdLBnuvXlUt
 */

protocol APIServiceDelegate: class {
    
    func apiLoaded()
}

class WeatherAPIClient {
    private init() {}
    weak var delegate: APIServiceDelegate?
    static let manager = WeatherAPIClient()
    private let id = "1krHhkxLdoql0xYggtUB4"
    private let secretId = "7BZndrbuPuS1o8S0OEarpVsn0FMW3bdLBnuvXlUt"
    func getForecast(for location: String, completion: @escaping (Weather) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        print("zipcode: \(location)")
        let forecastURL = "https://api.aerisapi.com/forecasts/\(location)?client_id=\(id)&client_secret=\(secretId)"
        
        print("url: \(forecastURL)")
        guard let url = URL(string: forecastURL) else { errorHandler(AppError.badURL(str: forecastURL)); return }
        let request = URLRequest(url: url)
        let completion: (Data) -> Void = { ( data: Data) in
            do {
                let json = try JSONDecoder().decode(Weather.self, from: data)
                self.delegate?.apiLoaded()
                completion(json)
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
}

