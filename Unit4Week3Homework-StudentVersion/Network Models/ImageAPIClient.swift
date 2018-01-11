//
//  ImageAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL(str: urlStr)); return}
        if let savedImage = FileManagerHelper.manager.getImage(with: urlStr) {
            completionHandler(savedImage)
            return
        }
        let completion = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {errorHandler(AppError.invalidImage); return}
            FileManagerHelper.manager.saveImage(with: urlStr, image: onlineImage)
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
