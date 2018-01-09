//
//  Pixabay.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    var hits: [Pixabay]
}

struct Pixabay: Codable {
    let tags: String
    let webformatURL: String
    let userImageURL: URL
    
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getPixaBayImages(from url: URL, completionHandler: @escaping([Pixabay]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let onlinePixabayImages = try JSONDecoder().decode([Pixabay].self, from: data)
                completionHandler(onlinePixabayImages)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}
