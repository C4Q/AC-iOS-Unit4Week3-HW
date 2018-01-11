//
//  UserDefaultsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Clint Mejia on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct UserDefaultsHelper {
    private init() { }
    static let manager = UserDefaultsHelper()
    private var keyName = "String"
    
    func get() -> String? {
        return UserDefaults.standard.string(forKey: keyName)
    }
    func set(to category: String) {
        UserDefaults.standard.setValue(category, forKey: keyName)
    }
    
}


