//
//  PixabayAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    var hits: [Pixabay]
}
struct Pixabay: Codable {
    let webformatURL: String
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getFirstImage(named str: String, completionHandler: @escaping (Pixabay) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabay: (Data) -> Void = {(data: Data) in
            do {
                let allResults = try JSONDecoder().decode(PixabayResults.self, from: data)
                let firstPixabay = allResults.hits.first
                completionHandler(firstPixabay!)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabay, errorHandler: errorHandler)
    }
    func getImages(named str: String, completionHandler: @escaping ([Pixabay]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabays: (Data) -> Void = {(data) in
            do {
                let allResults = try JSONDecoder().decode(PixabayResults.self, from: data)
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
        let urlStr = "https://pixabay.com/api/?key=\(PixabayAPIClient.key)&q=" + str
        guard let url = URL(string: urlStr) else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}

