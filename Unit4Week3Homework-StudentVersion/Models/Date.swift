//
//  Date.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

extension Date {
    
    static func timeStringFromTimeInterval(timeinterval: TimeInterval) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a" // 5:34 am
        let date = Date.init(timeIntervalSince1970: timeinterval)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    
    static func dateStringFromTimeInterval(timeinterval: TimeInterval) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM D" // Sat, Jan 6
        let date = Date.init(timeIntervalSince1970: timeinterval)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
