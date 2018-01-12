//
//  UserDefaultHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    private init() {}
    static let manager = UserDefaultsHelper()
//    let numberOfLoadsKey = "numberOfLoadedImages"
    let zipCodeKey = "savedZipCode"
    let unitsKey = "savedUnitPreference"
//    func incrementNumberOfLoadedImages() {
//        let loadsSoFar = UserDefaults.standard.integer(forKey: numberOfLoadsKey)
//        UserDefaults.standard.set(loadsSoFar + 1, forKey: numberOfLoadsKey)
//    }
//    func getNumberOfImageLoads() -> Int {
//        return UserDefaults.standard.integer(forKey: numberOfLoadsKey)
//    }
    func saveZipCode(zipCode: String) {
        UserDefaults.standard.setValue(zipCode, forKey: zipCodeKey)
    }
    func loadZipCode() -> String? {
        return UserDefaults.standard.object(forKey: zipCodeKey) as? String
    }
    
    func saveUnitPreference(unit: Int) {
        UserDefaults.standard.setValue(unit, forKey: unitsKey)
    }
    
    func loadUnitPreference() -> Int? {
        return UserDefaults.standard.object(forKey: unitsKey) as? Int
    }
}
