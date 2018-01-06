//
//  ImageCacheHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    private init(){}
    static let manager = ImageCache()
    private let myCache = NSCache<NSString, UIImage>()
    
    // get current cached image with urlstr
    func getImage(with urlStr: String) -> UIImage? {
        return myCache.object(forKey: urlStr as NSString)
    }
    
    //set image in completion handler to cache
    func addImage(with urlStr: String, and image: UIImage) {
        myCache.setObject(image, forKey: urlStr as NSString)
    }
    
    
}
