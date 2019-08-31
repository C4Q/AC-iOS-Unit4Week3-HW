//
//  ImageAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        if let savedImage = FileManagerHelper.manager.getImage(with: urlStr) {
            completionHandler(savedImage)
            return
        }
        if let cachedImage = NSCacheHelper.manager.getImage(with: urlStr) {
            completionHandler(cachedImage) //NSCached is to store the image with (imageUrl: UIImsge) key-value pair temporarily during the app launches.
            return
        }
        let completion = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {return}
            NSCacheHelper.manager.addImage(with: urlStr, and: onlineImage)
            FileManagerHelper.manager.saveImage(with: urlStr, image: onlineImage)
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
