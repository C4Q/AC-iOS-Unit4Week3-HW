//
//  DateFormatter.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Masai Young on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class DateManager {
    
    private init() {}
    static let shared = DateManager()
    
    var dateformatterToDate: DateFormatter = {
        let dateformatterToDate = DateFormatter()
        dateformatterToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateformatterToDate
    }()
    
    var dateformatterToString: DateFormatter = {
        let dateformatterToString = DateFormatter()
        dateformatterToString.dateFormat = "EEEE MMM d"
        return dateformatterToString
        
    }()
    
    var dateFormatterForTime:  DateFormatter {
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.dateFormat = "MMM d, h:mm a"
        return dateFormatterForTime
    }
    
    
    func convertDateToString(date: String) -> DateObject? {
        let newDate = dateformatterToDate.date(from: date)
        let dateStr = dateformatterToString.string(from: newDate!)
        let dateComponents = dateStr.components(separatedBy: " ")
        return DateObject(day: dateComponents[0], month: dateComponents[1], numericalDay: dateComponents[2])
    }
    
    func convertDateToTime(date: String) -> String? {
        let newDate = dateformatterToDate.date(from: date)
        return dateFormatterForTime.string(from: newDate!)
    }
    
}

struct DateObject {
    let day: String
    let month: String
    let numericalDay: String
}
