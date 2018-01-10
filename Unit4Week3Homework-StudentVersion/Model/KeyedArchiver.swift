//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class KeyedArchiverClient {
    
    static let shared = KeyedArchiverClient()
    private init() {}
    
    static let plistPathName = "SavedImages.plist"
    
    private var listOfSavedImageNames = [String]() {
        didSet {
            dump(listOfSavedImageNames)
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    private func dataFilePath(pathName: String) -> URL {
        return KeyedArchiverClient.shared.documentsDirectory().appendingPathComponent(pathName)
    }
    
    func saveFavorites() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(listOfSavedImageNames)
            try data.write(to: dataFilePath(pathName: KeyedArchiverClient.plistPathName), options: .atomic)
        } catch {
            print("Encoder error: \(error.localizedDescription)")
        }
    }
    
    func loadFavorites() {
        let decoder = PropertyListDecoder()
        let path = dataFilePath(pathName: KeyedArchiverClient.plistPathName)
        do {
            let data = try Data.init(contentsOf: path)
            listOfSavedImageNames = try decoder.decode([String].self, from: data)
        } catch {
            print("Decoder error: \(error.localizedDescription)")
        }
    }
    
    func clearFavorites() {
        try! FileManager.default.removeItem(at: dataFilePath(pathName: KeyedArchiverClient.plistPathName))
        listOfSavedImageNames.removeAll()
    }
    
    //Image Saver
    func saveImageToDisk(image: UIImage, artworkPath: String) -> Bool {
        // Use UIImagePNGRepresentation to convert the file to data and write to the file path
        guard let imageData = UIImagePNGRepresentation(image) else { return false }
        let imageURL = dataFilePath(pathName: artworkPath)
        do {
            try imageData.write(to: imageURL)
            listOfSavedImageNames.insert(artworkPath, at: 0)
        } catch {
            print("image saving error: \(error.localizedDescription)")
        }
        return true
    }
    
    func getImageFromDisk(artworkPath: String) -> UIImage? {
        let imageURL = dataFilePath(pathName: artworkPath)
        let image = UIImage(contentsOfFile: imageURL.path)
        return image
    }
    
    func deleteImageFromDisk(artworkPath: String) {
        let imageURL = dataFilePath(pathName: artworkPath)
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch {
            print("error removing: \(error.localizedDescription)")
        }
    }
    
    func replaceImage(oldArtworkPath: String, with newArtworkPath: String) {
        let oldImage = dataFilePath(pathName: oldArtworkPath)
        let newImage = dataFilePath(pathName: newArtworkPath)
        do {
            let _ = try FileManager.default.replaceItemAt(oldImage, withItemAt: newImage)
        } catch {
            print("error swapping images: \(error.localizedDescription)")
        }
    }
    
    func fetchListOfImages() -> [String] {
        return listOfSavedImageNames
    }
    
}

