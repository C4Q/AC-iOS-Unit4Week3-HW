//
//  PersistanceModel.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class PersistanceModel {
    static let kPath = "fave.plist"
    var favorites = [URL]() {
        didSet {
            saveFavorites()
        }
    }
    
    static let manager = PersistanceModel()
    private init() {}
    
    private func documetsDirectory() -> URL { // Creating a URL getting us into the document folder using that URL
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    private func dataFilePath(withPathName path: String) -> URL { // Allows us to talk about the stuff in our documents directory
        return PersistanceModel.manager.documetsDirectory().appendingPathComponent(path)
    }
    
    func saveFavorites() { // Saves the Plist
        do {
            let data = try PropertyListEncoder().encode(favorites)
            try data.write(to: dataFilePath(withPathName: PersistanceModel.kPath), options: .atomic)
            
        } catch {
            print(error)
        }
    }
    
    func load() { //When the app turns on : load
        do {
            let data = try Data(contentsOf: dataFilePath(withPathName: PersistanceModel.kPath ))
            favorites = try PropertyListDecoder().decode([URL].self, from: data)
        } catch {
            print(error)
        }
    }
    
}
