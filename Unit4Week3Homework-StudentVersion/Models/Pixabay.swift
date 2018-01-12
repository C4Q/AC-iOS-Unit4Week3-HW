//
//  Pixabay.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    let hits: [Pixabay]
    
}

struct Pixabay: Codable {
    let webformatURL: String
    let previewURL: String
    
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getPixaBayImages(from url: URL, completionHandler: @escaping([Pixabay]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = { (data: Data) in
          
            do {
                let onlinePixabayImages = try JSONDecoder().decode(PixabayResults.self, from: data)
                completionHandler(onlinePixabayImages.hits)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}
