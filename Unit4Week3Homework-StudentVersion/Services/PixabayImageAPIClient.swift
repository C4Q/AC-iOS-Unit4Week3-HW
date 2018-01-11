//
//  PixaBayImageAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayImages: Codable {
    let hits: [PixabayWrapper]
}

struct PixabayWrapper: Codable {
    let webformatURL: String
}

struct PixabayImageAPIClient {
    private init() {}
    static let manager = PixabayImageAPIClient()
    func getImage(from urlStr: String, completionHandler: @escaping ([PixabayWrapper]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let request = URLRequest(url:url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let allResults = try JSONDecoder().decode(PixabayImages.self, from: data)
                let allImages = allResults.hits
                completionHandler(allImages)
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
