//
//  PixabayAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

enum PixabayError: Error {
    case noResults
}

class PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    
    func getImages(searchTerm: String,
                   completionHandler: @escaping (Pixabay) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        guard let searchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let key = "7289666-d25d8897deb6cd7401b7a73c9"
        let urlStr = "https://pixabay.com/api/?key=\(key)&q=\(searchTerm)"
        
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badUrl)
            return
        }
        
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let pictureData = try JSONDecoder().decode(PixabayResults.self, from: data)
                if !pictureData.hits.isEmpty {
                    
                    let numberOfImages = pictureData.hits.count
                    let randomNumber = Int(arc4random_uniform(UInt32(numberOfImages - 1)))
                    
                    
                    completionHandler(pictureData.hits[randomNumber])
                } else {
                    errorHandler(PixabayError.noResults)
                }
            } catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
        
    }
    
}

