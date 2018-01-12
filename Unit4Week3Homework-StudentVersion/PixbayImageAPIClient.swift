//
//  ImageAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


struct Images: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let webformatURL: String?
}


struct PixbayImageAPIClient {
    private init() {}
    static let manager = PixbayImageAPIClient()
    func getImages(named searchStr: String,
        completionHandler: @escaping (Images) -> Void,
        errorHandler: @escaping (Error) -> Void) {
        
        let myKey = "7289987-af583f743f44e76316a182e24"
        let urlStr = "https://pixabay.com/api/?key=\(myKey)&q=\(searchStr)&image_type=photo"
        
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let images = try JSONDecoder().decode(Images.self, from: data)
                dump(images)
                completionHandler(images)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}





