//
//  UserDefaultsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Richard Crichlow on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
struct UserDefaultsHelper {
    static let manager = UserDefaultsHelper()
    private init() {}
    
    //private let dateKey = "date"
    private let zipcodeKey = "zipcode"
    private let zipcodeKeyAsString = "zipcodeKeyasString"
    
    //Save Stuff
//    func getTomorrowDate() -> Date? {
//        return UserDefaults.standard.value(forKey: dateKey) as? Date
//    }
//    func getZipcode() -> Int? {
//        return UserDefaults.standard.integer(forKey: zipcodeKey)
//    }
    func getZipcodeAsString() -> String? {
        return UserDefaults.standard.string(forKey: zipcodeKeyAsString)
    }
    
    //Get Stuff
//    func setTomorrowDate(to newDate: Date) {
//        UserDefaults.standard.setValue(newDate, forKey: dateKey)
//    }
//    func setZipcode(to newZipcode: Int) {
//        UserDefaults.standard.setValue(newZipcode, forKey: zipcodeKey)
//    }
    func setZipcodeAsString(to newZipcode: String) {
        UserDefaults.standard.setValue(newZipcode, forKey: zipcodeKeyAsString)
    }
}
