//
//  Network.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            completionHandler(cachedResponse.data)
            return
        }
        
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
                
            }
            }.resume()
    }
}

struct WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    func getForecast(from urlStr: String, completionHandler: @escaping (Weather) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        
//        if let cachedImage = ImageCache.manager.getImage(urlStr: urlStr) {
//            completionHandler(cachedImage)
//            return
//        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completionHandler(weather)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getPictures(from urlStr: String, completionHandler: @escaping (PixabayResults) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        
//        if let cachedImage = ImageCache.manager.getImage(urlStr: urlStr) {
//            completionHandler(cachedImage)
//            return
//        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let pictures = try JSONDecoder().decode(PixabayResults.self, from: data)
                completionHandler(pictures)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

struct ImageDownloader {
    private init() {}
    static let manager = ImageDownloader()
    func getImage(from urlStr: String, completionHandler: @escaping (Data) -> Void, errorHandler: (Error) -> Void) {
        // MARK: - Downloads images async
        if let albumURL = URL(string: urlStr) {
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        completionHandler(data)
                    }
                }
            }
        }
    }
}

