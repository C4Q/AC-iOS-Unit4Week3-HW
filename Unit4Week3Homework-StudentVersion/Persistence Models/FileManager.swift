//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Nicole Souvenir on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import UIKit
import Foundation


//public -> if you need to use it in any other  file: USUALLY AT THE TOP OF THE PAGE : loading and adding

//private -> if you don't want any other file to see your func



class FileManagerHelper {
    private init() {}
    static let manager = FileManagerHelper()
    
    var pathName = "sevenDayForecast.plist"
    
    var favPathName = "favorites.plist"
    
    
    //don't really want to persist the forecast
    private var sevenDayForecast = [SevenDayForecast]() {
        didSet {
            saveForecastToSandBox()
        }
    }
    
    //what you are wanting to persist
    var favoriteImages = [UIImage]()
    
    private var favoriteURLS = [String]() {
        didSet {
            saveFavoriteImageToSandBox()
        }
    }
    
    
    //MARK: Saving FAVORITES
    //This saves the array of Favorites to the phone: DONT WORRY ABOUT IT.. LOOK UP!
    private func saveFavoriteImageToSandBox() {
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

    
    //When the save button is clicked
    func addFavoriteImageToFileManager(from urlstr: String) {
        favoriteURLS.append(urlstr)
    }
   ///////////////////////////////////////////////////
    
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
    
    //Get Favorites Images to VC from FM
    func getFavoriteImagesFromFileManager() -> [UIImage]{
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
    
    //Delete func for favorites
        func deleteFavImage(favPathName: String) {
            let imageURL = dataFilePath(withPathName: favPathName) // let the Image URL get the file path name where it is stored in the phone
            do {
                try FileManager.default.removeItem(at: imageURL) //try to remove that URL at the place it is stord in the phone
            } catch {
                print("error removing: \(error.localizedDescription)")
            }
            var indexCounter = 0
            if favoriteURLS.contains(favPathName) {// if the [URLString] contains that filePathName
                
                for savedImageURL in favoriteURLS {//iterate thru
                    
                    if savedImageURL == favPathName {//if that saved image URL steing matches the path name that it's supposed to be saved under
                        favoriteURLS.remove(at: indexCounter) // remove that URL from the sandbox
                    }
                    indexCounter += 1 //move onto the next index to do the check
                }
            }
        }


    //MARK: SAVING IMAGES
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
    
    
    //MARK: FORECAST SAVING
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

//class FileManagerHelper {
//    private init() {}
//    static let manager = FileManagerHelper()
//
//    var pathName = "sevenDayForecast.plist" //do we need it????
//    var favPathName = "Favorites.plist"
//
//    private var sevenDayForecast = [SevenDayForecast]() {
//        didSet {
//            saveForecastToSandBox()
//        }
//    }
//
//    var favoriteImages = [UIImage]()
//
//    private var favoriteURLS = [String]() {
//        didSet {
//            saveFavorites()
//        }
//    }
//
//    //This saves the array of Favorites to the phone
//    private func saveFavorites() {
//        //Save URLs
//        let path = dataFilePath(withPathName: favPathName)
//        do {
//            let data = try PropertyListEncoder().encode(favoriteURLS)
//            try data.write(to: path, options: .atomic)
//        }
//        catch {
//            print("WHYYYYYYYYY")
//        }
//    }
//
//    //When the save button is clicked
//    func addFavoriteImage(from urlstr: String) {
//        favoriteURLS.append(urlstr)
//    }
//
//    //Get Favorites Images to VC
//    func getFavoritesImages() -> [UIImage]{
//        return favoriteImages
//    }
//
//    //This is called in the app delegate to bring up favorited images
//    func loadFavoritesFromSandbox() {
//        for imageURLS in favoriteURLS {
//            if let loadedimage = getImage(with: imageURLS) {
//                favoriteImages.append(loadedimage)
//            } else {
//                print("No image with that name saved on phone")
//            }
//        }
//    }
//
//
//    //MARK:  - File Manager BoilerPlate
//
//    //returns documents directory path for app sandbox
//    private func documentsDirectory() -> URL {
//        //this is finding the document folder in the app
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        //return document folder url path
//        return paths[0]
//    }
//
//    // returns the path for supplied name from the documents directory
//    private func dataFilePath(withPathName path: String) -> URL {
//        //now you can write to the file/pathName you pass in! (If the file name doesn't exsist, it will create it)
//        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
//    }
//
//
//    //MARK: - SAVING AND LOADING FORECASTS
//
//    // takes forecast from phone(sandbox) brings it to FileManager
//    func loadForecastFromFileManager(using zipCode: String) {
//        let newPathName = zipCode + ".plist" // EX) 60506.plist
//        self.pathName = newPathName
//
//        let path = dataFilePath(withPathName: pathName)
//
//        do {
//            let data = try Data(contentsOf: path)
//            let forecast = try PropertyListDecoder().decode([SevenDayForecast].self, from: data)
//            self.sevenDayForecast = forecast
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
//
//
//    //takes forecast from FileManager and places in VC
//    func addForecastToVC() -> [SevenDayForecast] {
//        return sevenDayForecast
//    }
//
//
//    func sendForecastToFileManager(forecast: [SevenDayForecast], with zipCode: String){
//        let newPathName = zipCode + ".plist" // EX) 60506.plist
//        self.pathName = newPathName // saving to pathName so that you can actually save it in File Manager
//        //saving the array from VC to the array in FileManager
//        sevenDayForecast = forecast
//    }
//
//    //takes array from File Manager and puts into sandbox
//    func saveForecastToSandBox() {
//        //encode into data so they can be saved with propertyListEncoder
//        let path = dataFilePath(withPathName: pathName)
//        do {
//            let data = try PropertyListEncoder().encode(sevenDayForecast)
//            //write this data to a plist
//            try data.write(to: path, options: .atomic)
//
//        }
//        catch {
//            print("error encoding items: \(error.localizedDescription)")
//        }
//    }
//
//
//    //MARK: - SAVING IMAGES
//
//    //Saving Images To Disk
//    func saveImage(with urlStr: String, image: UIImage) {
//        let imageData = UIImagePNGRepresentation(image)
//        let imagePathName = urlStr.components(separatedBy: "/").last!
//        let url = dataFilePath(withPathName: imagePathName)
//        do {
//            try imageData?.write(to: url)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    //Getting images from disk
//    func getImage(with urlStr: String) -> UIImage? {
//        do {
//            let imagePathName = urlStr.components(separatedBy: "/").last!
//            let url = dataFilePath(withPathName: imagePathName)
//            let data = try Data(contentsOf: url)
//            return UIImage(data: data)
//        }
//        catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//}

