//
//  PixabayModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class PixabayModel {
    private init() {}
    static let manager = PixabayModel()
    
    private let PixabayAPIKey = "7289690-cab1c1f247d0d6727c84a8fef"
    
    private var pixabayResults: PixabayResults?
    
    func writeResults(results: PixabayResults) {
        pixabayResults = results
    }
    
    func fetchRandomPictureEndpoint() -> String? {
        guard let numberOfPicture = pixabayResults?.hits.count else { return nil }
        guard numberOfPicture > 0 else { return nil }
        
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfPicture)))
        let pic = pixabayResults?.hits[randomNumber]
        
        guard let endpoint = pic?.webformatURL else { return nil }
        print(endpoint)
        return endpoint
    }
    
    func uniqueStringFromEndpoint(_ endpoint: String) -> String {
        let uniqueStringWithFileExtension = endpoint.components(separatedBy: "/").last!
        let uniqueStringReadyForSaving = uniqueStringWithFileExtension.components(separatedBy: ".").first!
        return uniqueStringReadyForSaving
    }
    
    func fetchPictures(searchTerm: String, completion: @escaping (PixabayResults) -> Void) {
        
        var endpoint = URLComponents(string: "https://pixabay.com/api/")
        endpoint?.queryItems = [
            URLQueryItem(name: "key", value: PixabayAPIKey),
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "category", value: "places"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let pixabayEndpoint = endpoint?.url?.absoluteString else { return }
        PixabayAPIClient.manager.getPictures(from: pixabayEndpoint,
                                             completionHandler: completion,
                                             errorHandler: {print($0)})
    }
    
}

struct PixabayResults: Codable {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

struct Hit: Codable {
    let previewHeight, likes, favorites: Int
    let tags: String
    let webformatHeight, views, webformatWidth, previewWidth: Int
    let comments, downloads: Int
    let pageURL, previewURL, webformatURL: String
    let imageWidth, userID: Int
    let user, type: String
    let id: Int
    let userImageURL: String
    let imageHeight: Int
    
    enum CodingKeys: String, CodingKey {
        case previewHeight, likes, favorites, tags, webformatHeight, views, webformatWidth, previewWidth, comments, downloads, pageURL, previewURL, webformatURL, imageWidth, user, type, id, userImageURL, imageHeight
        case userID = "user_id"
    }
}
