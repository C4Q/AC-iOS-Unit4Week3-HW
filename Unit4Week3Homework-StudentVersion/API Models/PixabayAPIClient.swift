//
//  PixabayAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    var hits: [Pixabay]
}
struct Pixabay: Codable {
    let webformatURL: String
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getImages(from city: String, completionHandler: @escaping (Pixabay) -> Void, errorHandler: (Error) -> Void) {
        
        let key = "7289923-0b68ed7d233fab7c0c5f1be3f"
        guard let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(city)") else {return}
        let request = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let images = try JSONDecoder().decode(PixabayResults.self, from: data)
                
                if !images.hits.isEmpty {
                    let randomImage = Int(arc4random_uniform(UInt32(images.hits.count-1)))
                    completionHandler(images.hits[randomImage])
                }
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

