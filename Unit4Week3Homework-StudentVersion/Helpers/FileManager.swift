//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

protocol Foo {
    func bar() -> ()
}

class FileManagerHelper {
    private init() {}
    var savedPixaBayImagesPath = "SavedCityImages.plist"
    static let manager = FileManagerHelper()
    
    private var pixaBayImages = [UIImage]() {
        didSet {
//            removeDupes()
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
    
//    func removeDupes() {
//        var imageURLSet = Set<String>()
//        var noDupeArr = [Pixabay]()
//        for image in pixaBayImages {
//            let (inserted, _) = imageURLSet.insert(image.webformatURL)
//            if inserted {
//                noDupeArr.append(image)
//            }
//        }
//        if pixaBayImages.count != noDupeArr.count { pixaBayImages = noDupeArr }
//    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(pixaBayImages)
            let phoneURL = dataFilePath(withPathName: savedPixaBayImagesPath)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: savedPixaBayImagesPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedImages = try propertyListDecoder.decode([UIImage].self, from: encodedData)
           pixaBayImages = savedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func addNew(savedImage: UIImage) {
        pixaBayImages.append(savedImage)
    }
    
    func getAllPixabayImages() -> [UIImage] {
        return pixaBayImages
    }
    
    //USE THIS ONE
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    //THIS IS ONLY FOR THE ABOVE METH.a.OD
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

