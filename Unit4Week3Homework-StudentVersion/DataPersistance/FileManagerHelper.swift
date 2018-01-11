//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Foundation

class FileManagerHelper {
    private init() {}
    
    static let manager = FileManagerHelper()
    
    var pathName = "sevenDayForecast.plist"
    var favPathName = "Favorites.plist"
    
    // Skipping saving Forecast, since weather can change during the day
    private var sevenDayForecast = [SevenDayForecast]() {
        didSet {
            saveForecastToSandBox()
        }
    }
    
    var favoriteImages = [UIImage]()
    
    private var favoriteURLS = [String]() {
        didSet {
            saveFavoritesToSandbox()
        }
    }
    
    //This saves the array of Favorites to the phone
    private func saveFavoritesToSandbox() {
        //Save URLs
        let path = dataFilePath(withPathName: favPathName)
        do {
            let data = try PropertyListEncoder().encode(favoriteURLS)
            try data.write(to: path, options: .atomic)
        }
        catch {
            print("WHYYYYYYYYY")
        }
    }
    
    // Load array of favoriteURLs from SandBox
    func loadFavoritesFromSandBox() {
        //Save URLs
        let path = dataFilePath(withPathName: favPathName)
        do {
            let data = try Data(contentsOf: path)
            let arrayOfFavoritedImageUrlStrings = try PropertyListDecoder().decode([String].self, from: data)
            self.favoriteURLS = arrayOfFavoritedImageUrlStrings
        }
        catch {
            print("error decoding items: \(error.localizedDescription)")
        }
    }
    
    //When the save button is clicked
    func addFavoriteImage(from urlstr: String) {
        favoriteURLS.append(urlstr)
    }
    
    //Get Favorites Images to VC from File Manager
    func getFavoritesImages() -> [UIImage]{
        return favoriteImages
    }
    
    //This is called in the app delegate to bring up favorited images
    func loadFavorites() {
        var arrayOfFavorites = [UIImage]()
        for imageURLS in favoriteURLS {
            if let loadedimage = getImage(with: imageURLS) {
                arrayOfFavorites.append(loadedimage)
            } else {
                print("No image with that name saved on phone")
            }
        }
        self.favoriteImages = arrayOfFavorites
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
    
    
    //Getting images from disk
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
    
    
    // takes forecast from phone(sandbox) brings it to FileManager
    func loadForecastFromFileManager(using zipCode: String) {
        let newPathName = zipCode + ".plist" // EX) 60506.plist
        self.pathName = newPathName
        
        let path = dataFilePath(withPathName: pathName)
        
        do {
            let data = try Data(contentsOf: path)
            let forecast = try PropertyListDecoder().decode([SevenDayForecast].self, from: data)
            self.sevenDayForecast = forecast
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //takes forecast from FileManager and places in VC
    func addForecastToVC() -> [SevenDayForecast] {
        return sevenDayForecast
    }
    
    func sendForecastToFileManager(forecast: [SevenDayForecast], with zipCode: String){
        let newPathName = zipCode + ".plist" // EX) 60506.plist
        self.pathName = newPathName // saving to pathName so that you can actually save it in File Manager
        //saving the array from VC to the array in FileManager
        sevenDayForecast = forecast
    }
    
    //takes array from File Manager and puts into sandbox
    func saveForecastToSandBox() {
        //encode into data so they can be saved with propertyListEncoder
        let path = dataFilePath(withPathName: pathName)
        do {
            let data = try PropertyListEncoder().encode(sevenDayForecast)
            //write this data to a plist
            try data.write(to: path, options: .atomic)
            
        }
        catch {
            print("error encoding items: \(error.localizedDescription)")
        }
    }
    
    //returns documents directory path for app sandbox
    private func documentsDirectory() -> URL {
        //this is finding the document folder in the app
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //return document folder url path
        return paths[0]
    }
    
    // returns the path for supplied name from the documents directory
    private func dataFilePath(withPathName path: String) -> URL {
        //now you can write to the file/pathName you pass in! (If the file name doesn't exsist, it will create it)
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
}
