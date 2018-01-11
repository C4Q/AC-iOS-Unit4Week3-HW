//
//  UserDefaultManager.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct UserDefaultManager {
    private init() {}
    static let shared = UserDefaultManager()
    
    var defaults = UserDefaults.standard
    let userDefaultKey = "SavedZipCode"
    
    func setDefaultZip(value: Any, key: String) {
        defaults.set(value, forKey: key)
    }
    
    func fetchDefaultZip(key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    //    let customObject = CustomClass()
    //    let encodedObject = try! PropertyListEncoder().encode(customObject)
    //    defaults.set(encodedObject, forKey: "encodedObject")
    //
    //    let encodedData = defaults.object(forKey: "encodedObject") as! Data
    //    let readyObject = try! PropertyListDecoder().decode(CustomClass.self, from: encodedData)
    
}
