//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Caroline Cruz on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FileManagerHelper {
    private init() {}
    let cityImagesPath = "allCityImages.plist"
    static let manager = FileManagerHelper()
    
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr //.components(separatedBy: "/").last!
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
            let imagePathName = urlStr //.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private var cityImages = [Favorite]() {
        didSet {
            //print(cityImages)
            removeDupes()
            saveImages()
        }
    }
    
    func removeDupes() {
        var imageURLSet = Set<String>()
        var noDupeArr = [Favorite]()
        for image in cityImages {
            let (inserted, _) = imageURLSet.insert(image.cityName)
            if inserted {
                noDupeArr.append(image)
            }
        }
        if cityImages.count != noDupeArr.count { cityImages = noDupeArr }
    }
    
    func addNew(newCityImage: Favorite) {
        cityImages.append(newCityImage)
    }
    func getAllCityImages() -> [Favorite] {
        return cityImages
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(cityImages)
            let phoneURL = dataFilePath(withPathName: cityImagesPath)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: cityImagesPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedImages = try propertyListDecoder.decode([Favorite].self, from: encodedData)
            cityImages = savedImages
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
        print(paths[0])
        return paths[0]
    }
}
