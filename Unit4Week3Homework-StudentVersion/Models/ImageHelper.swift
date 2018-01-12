//
//  ImageHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

enum ImageError: Error {
    case badUrl
    case badData
}

class ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        
        if let savedImage = DataPersistenceHelper.manager.getImage(with: urlStr) {
            completionHandler(savedImage)
            return
        }
        if let cachedImage = NSCacheHelper.manager.getImage(with: urlStr) {
            completionHandler(cachedImage)
            return
        }
        
        
        
        guard let url = URL(string: urlStr) else {
            errorHandler(ImageError.badUrl)
            return
        }
        let completion = {(data: Data) in
            if let onlineImage = UIImage(data: data) {
                NSCacheHelper.manager.addImage(with: urlStr, and: onlineImage)
                DataPersistenceHelper.manager.saveImage(with: urlStr, image: onlineImage)
                completionHandler(onlineImage)
            } else {
                errorHandler(ImageError.badData)
            }
        }
        let request = URLRequest(url: url)
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
