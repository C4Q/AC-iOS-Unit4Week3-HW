//
//  UserDefaultsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Ashlee Krammer on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct UserDefaultHelper {
    static let manager = UserDefaultHelper()
    private init() {}
    let zipKey = "zipKey"
    func getZip() -> String? {
        return UserDefaults.standard.string(forKey: zipKey)
    }
    func setZip(to thisZip: String) {
        UserDefaults.standard.setValue(thisZip, forKey: zipKey)
    }
}
