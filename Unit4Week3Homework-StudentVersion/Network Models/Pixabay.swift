//
//  CityImage.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
struct PixabayInfo: Codable {
   let totalHits: Int
    let hits: [CityImage]
}

struct CityImage: Codable {
    let webformatURL: String
    let id: Int
}

struct CityAPIClient {
    private init(){}
    static let shared = CityAPIClient()
    func getCityImages(from city: String,
                      completionHandler: @escaping ([CityImage]) -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        let validCity = city.lowercased().replacingOccurrences(of: " ", with: "_")
        let urlStr = "https://pixabay.com/api/?key=7291288-dd66e346e0fae86cb22ffd217&q=\(validCity)&image_type=photo"
        
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineInfo = try JSONDecoder().decode(PixabayInfo.self, from: data)
             let images = onlineInfo.hits
                
              //  FileManagerHelper.manager.addNew(newImage: newImage)
                completionHandler(images)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
