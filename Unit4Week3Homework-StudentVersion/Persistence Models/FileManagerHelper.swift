//
//  FileManagerHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

//protocol Foo {
//    func bar() -> ()
//}

class FileManagerHelper {
    private init() {}
    let favoriteImagesPath = "favoriteImages.plist"
    static let manager = FileManagerHelper()
    
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func getImage(with urlStr: String) -> UIImage? {
        do {
            let imagePathName = urlStr.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private var favoriteImages = [FavoriteImage]() {
        didSet {
            removeDupes()
            saveImages()
        }
    }
    
    func removeDupes() {
        var imageURLSet = Set<String>()
        var noDupeArr = [FavoriteImage]()
        for favorite in favoriteImages {
            let (inserted, _) = imageURLSet.insert(favorite.url)
            if inserted {
                noDupeArr.append(favorite)
            }
        }
        if favoriteImages.count != noDupeArr.count { favoriteImages = noDupeArr }
    }
    
    func addNew(newFavoriteImage: FavoriteImage) {
        favoriteImages.append(newFavoriteImage)
    }
    func getAllFavoriteImages() -> [FavoriteImage] {
        return favoriteImages
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(favoriteImages)
            let imageURL = dataFilePath(withPathName: favoriteImagesPath)
            try encodedData.write(to: imageURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let imageURL = dataFilePath(withPathName: favoriteImagesPath)
            let encodedData = try Data(contentsOf: imageURL)
            let savedImages = try propertyListDecoder.decode([FavoriteImage].self, from: encodedData)
            favoriteImages = savedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //USE THIS ONE
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    //THIS IS ONLY FOR THE ABOVE METHOD
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
