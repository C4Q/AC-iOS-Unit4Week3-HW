//
//  Favorite.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Lisa J on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

struct Favorite: Codable {
    let webformatURL: String
    let cityName: String
    let id: Int
    
    // computed property to return image from documents
    var image: UIImage? {
        set{}
        get {
            let imageURL = PersistentStoreManager.manager.dataFilePath(withPathName: "\(id)")
            let docImage = UIImage(contentsOfFile: imageURL.path)
            return docImage
        }
    }
}
