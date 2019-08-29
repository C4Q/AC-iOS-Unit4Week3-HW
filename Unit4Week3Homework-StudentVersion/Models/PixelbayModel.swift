//
//  PixelbayModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

//pixabayAPIkey: 7290874-fad8a471f8b0a9ff7d93a719b


struct ImageResponseWrapper: Codable {
    let totalHits: Int // The number of images accessible through the API. By default, the API is limited to return a maximum of 500 images per query.
    let hits: [PixabayImage]
}
struct PixabayImage: Codable {
    let previewURL: String
    let webURL: String
    let id: Double //A unique identifier for updating expired image URLs
    enum CodingKeys: String, CodingKey {
        case previewURL
        case webURL = "webformatURL"
        case id
    }
}
