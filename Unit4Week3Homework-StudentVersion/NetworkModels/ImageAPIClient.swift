//
//  ImageAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        guard let url = URL(string: urlStr.removingWhitespaces()) else {
            errorHandler(AppError.invalidImage)
            return
        }
        
        //Check to see if you downloaded an image with the same url
        if let savedImage = FileManagerHelper.manager.getImage(with: urlStr) {
            completionHandler(savedImage)
            print("Loaded Image from Phone from API Client")
        } else {
            //If there is no image saved, get it from the internet
            
            let completion: (Data) -> Void = {(data: Data) in
                guard let onlineImage = UIImage(data: data) else {
                    return
                    
                }
                completionHandler(onlineImage)
                
                //This saves the image to the phone
                FileManagerHelper.manager.saveImage(with: urlStr, image: onlineImage)
                print("Saved Image to Phone")
                
            }
            
            NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                                  completionHandler: completion,
                                                  errorHandler: errorHandler)
        }
    }
}

//class ImageAPIClient {
//    private init() {}
//    static let manager = ImageAPIClient()
//
//    func loadImage(from urlStr: String,
//                   completionHandler: @escaping (UIImage) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {
//
//        guard let url = URL(string: urlStr) else {
//            errorHandler(AppError.invalidImage)
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        //Check to see if you downloaded an image with the same url
//        if let savedImage = FileManagerHelper.manager.getImage(with: urlStr) {
//            completionHandler(savedImage)
//            print("Loaded image from phone")
//        } else{
//
//            //If there is no image saved, get it from the internet
//            let completion: (Data) -> Void = {(data: Data) in
//                guard let onlineImage = UIImage(data: data) else {
//                    return
//                }
//                completionHandler(onlineImage)
//                //This saves the image to the phone
//                FileManagerHelper.manager.saveImage(with: urlStr, image: onlineImage)
//                print("Saved image to phone from internet")
//            }
//            NetworkHelper.manager.performDataTask(with: request,
//                                                  completionHandler: completion,
//                                                  errorHandler: errorHandler)
//
//        }
//    }
//}

