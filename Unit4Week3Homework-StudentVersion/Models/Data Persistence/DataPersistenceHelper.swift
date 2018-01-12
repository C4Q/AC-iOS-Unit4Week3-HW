//
//  DataPersistenceHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Reiaz Gafar on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DataPersistenceHelper {
    
    // Singleton
    private init() {}
    static let manager = DataPersistenceHelper()
    
    let filePath = "FavoritedImages.plist"
    
    struct FavoritedImage: Codable {
        let city: String
        let imgUrl: String
    }
    
    
    // Save everytime it changes
    private var favoritedImages = [FavoritedImage]() {
        didSet {
            saveFavoritedImages()
        }
    }
    
    // Gets the doc dir path
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Gets the file path in doc dir
    private func dataFilePath(withPathName path: String) -> URL {
        return DataPersistenceHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    // Loads
    func loadFavoritedImages() {
        var data = Data()
        do {
            data = try Data.init(contentsOf: DataPersistenceHelper.manager.dataFilePath(withPathName: filePath))
        } catch {
            print("Error retrieving data. \(error.localizedDescription)")
            return
        }
        
        do {
            favoritedImages = try PropertyListDecoder().decode([FavoritedImage].self, from: data)
        } catch {
            print("Plist decoding error. \(error.localizedDescription)")
        }
    }
    
    // Returns this object's array
    func getFavoritedImages() -> [FavoritedImage] {
        return favoritedImages
    }
    
    //Saving Images To Disk
    func saveImage(with imgUrl: String, image: UIImage) -> Bool {
        
        let imgPng = UIImagePNGRepresentation(image)!
        let imagePath = dataFilePath(withPathName: UUID().description)
        
        
        
        do {
            try imgPng.write(to: imagePath, options: .atomic)
        } catch {
            print("Error saving image. \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func getImage(with imgUrl: String) -> UIImage? {
        do {
            let imgPath = dataFilePath(withPathName: "\(imgUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)")
            let data = try Data(contentsOf: imgPath)
            return UIImage(data: data)
        }
        catch {
            //print(error.localizedDescription)
            return nil
        }
    }
    
    
    
    
    // Saves current array into the doc dir
    private func saveFavoritedImages() {
        var data = Data()
        
        do {
            data = try PropertyListEncoder().encode(favoritedImages)
        } catch {
            print("Plist encoding error. \(error.localizedDescription)")
            return
        }
        
        do {
            try data.write(to: DataPersistenceHelper.manager.dataFilePath(withPathName: filePath), options: .atomic)
            
        } catch {
            print("Writing to disk error. \(error.localizedDescription)")
        }
        
    }
    
    // Also saves the image in the doc dir
    func addFavoritedImage(city: String, imgUrl: String, image: UIImage) -> Bool {
        
        if saveImage(with: imgUrl, image: image) {
            let favImage = FavoritedImage(city: city, imgUrl: imgUrl)
            favoritedImages.append(favImage)
            return true
        }
        return false
    }
    
    // Deletes save
    func deleteFavoritedImages() {
        favoritedImages.removeAll()
    }
    
    
    func alreadyFavorited(imgUrl: String) -> Bool {
        
        let indexExist = favoritedImages.index{ $0.imgUrl == imgUrl }
        if indexExist != nil { return true }
        
        return false
        
    }
    
    
}

