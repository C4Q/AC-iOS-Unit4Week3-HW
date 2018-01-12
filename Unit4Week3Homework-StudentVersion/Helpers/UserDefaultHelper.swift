//
//  UserDefaultHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct UserDefaultHelper {
    private init() {}
    static let manager = UserDefaultHelper()
    private let ZipCodeKey = "Zipcode"
    func getZipCode() -> String? {
        return UserDefaults.standard.string(forKey: ZipCodeKey)
    }
    func setZipCode(to ZipCode: String) {
        UserDefaults.standard.setValue(ZipCode, forKey: ZipCodeKey)
    }
}
