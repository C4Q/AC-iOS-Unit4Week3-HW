//
//  PixelBalAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    static let key = "7290874-fad8a471f8b0a9ff7d93a719b"
    func getFirstImage(named str: String, completionHandler: @escaping (PixabayImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabay: (Data) -> Void = {(data: Data) in
            do {
                let allResults = try JSONDecoder().decode(ImageResponseWrapper.self, from: data)
                let firstPixabay = allResults.hits.first ?? PixabayImage(previewURL: "", webURL: "", id: 0.0)
                
                completionHandler(firstPixabay)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabay, errorHandler: errorHandler)
    }
    
    func getImages(named str: String, completionHandler: @escaping ([PixabayImage]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabays: (Data) -> Void = {(data) in
            do {
                let allResults = try JSONDecoder().decode(ImageResponseWrapper.self, from: data)
                let pixabays = allResults.hits
                completionHandler(pixabays)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabays, errorHandler: errorHandler)
    }
    
    
    private func buildRequest(with str: String) -> URLRequest? {
        let urlStr = "https://pixabay.com/api/?key=\(PixabayAPIClient.key)&q=" + str + "&safesearch=true"
        guard let url = URL(string: urlStr.removingWhitespaces()) else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}




