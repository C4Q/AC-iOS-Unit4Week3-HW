//
//  KeyArchiver.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class KeyedArchiverClient {
    
    static let shared = KeyedArchiverClient()
    private init() {}
    
    static let plistPathName = "SavedImages.plist"
    
    private var listOfImageNames = [String]() {
        didSet {
            savePixabays()
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    private func dataFilePath(pathName: String) -> URL {
        let formattedPathName = pathName.components(separatedBy: "/").last!
        
        return KeyedArchiverClient.shared.documentsDirectory().appendingPathComponent(formattedPathName)
    }

    
func saveImageToDisk(image: UIImage, artworkPath: String) -> Bool {
    // Use UIImagePNGRepresentation to convert the file to data and write to the file path
    guard let imageData = UIImagePNGRepresentation(image) else { return false }
    let imageURL = dataFilePath(pathName: artworkPath)
    do {
        try imageData.write(to: imageURL)
        listOfImageNames.append(artworkPath)
    } catch {
        print("image saving error: \(error.localizedDescription)")
    }
    return true
}

func getImage(artworkPath: String) -> UIImage? {
    let formattedPathName = artworkPath.components(separatedBy: "/").last!
    let imageURL = dataFilePath(pathName: formattedPathName)
    let image = UIImage(contentsOfFile: imageURL.path)
    return image
}

func deleteImage(artworkPath: String) {
    let imageURL = dataFilePath(pathName: artworkPath)
    do {
        try FileManager.default.removeItem(at: imageURL)
    } catch {
        print("error removing: \(error.localizedDescription)")
    }
}
    
    private func savePixabays() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(listOfImageNames)
            let phoneURL = dataFilePath(pathName: KeyedArchiverClient.plistPathName)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print("Encoding error: " + error.localizedDescription)
        }
    }
    
    func loadPixabays() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(pathName: KeyedArchiverClient.plistPathName)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedPixabays = try propertyListDecoder.decode([String].self, from: encodedData)
            listOfImageNames = savedPixabays
        }
        catch {
            print("Decoding error: " + error.localizedDescription)
        }
    }

func fetchListOfImages() -> [String] {
    return listOfImageNames
}

}
