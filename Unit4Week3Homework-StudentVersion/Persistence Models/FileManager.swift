//
//  FileManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Nicole Souvenir on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import UIKit
import Foundation

class FileManagerHelper {
    private init() {}
    let pathName = "sevenDayForecast.plist"
    
    static let manager = FileManagerHelper()
    
    private var sevenDayForecast = [Forecast]() {
        didSet {
            saveForecast()
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
    
    // takes forecast from phone brings it to FileManager
    func loadForecast() {
        let path = dataFilePath(withPathName: FileManagerHelper.pathName)
        
        do {
            let data = try Data(contentsOf: path)
            let forecast = try PropertyListDecoder().decode([Forecast].self, from: data)
            self.sevenDayForecast = forecast
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //takes forecast from FileManager and places in VC
    func addForecastToVC() -> [Forecast] {
        return sevenDayForecast
    }
    
    func saveForecast() {
        //encode into data so they can be saved with propertyListEncoder
        let path = dataFilePath(withPathName: FileManagerHelper.pathName)
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
