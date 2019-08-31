//
//  FileManagerHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FileManagerHelper {
    private init() {}
    
    let cityImagesPath = "cityImages.plist"
    static let manager = FileManagerHelper()
    private var cityImages = [CityImage]() {
        didSet {
            print(cityImages)
            saveImages()
        }
    }
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print("Saving image error: \(error.localizedDescription)")
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
            print(" \(error.localizedDescription)")
            return nil
        }
    }
    
  
    func addNew(newImage: CityImage) {
        let existIndex = self.cityImages.index(where: {newImage.id == $0.id})
        if existIndex != nil {return}
        cityImages.append(newImage)
    }
    func getAllCityImages() -> [CityImage] {
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
            print("Saving images error: \(error.localizedDescription)")
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: cityImagesPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedImages = try propertyListDecoder.decode([CityImage].self, from: encodedData)
            cityImages = savedImages
        }
        catch {
            print("Loading images error:  \(error.localizedDescription)")
        }
        
        print("==============================")
        print(dataFilePath(withPathName: cityImagesPath))
         print("==============================")
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
