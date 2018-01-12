//
//  Pixabay.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    var hits: [Pixabay]
}

struct Pixabay: Codable {
    let likes: Int
    let tags: String
    let webformatURL: String
}

