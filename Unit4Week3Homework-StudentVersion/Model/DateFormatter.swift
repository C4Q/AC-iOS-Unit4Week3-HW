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
        dateformatterToString.dateFormat = "EEEE, MMM d, yyyy"
        return dateformatterToString
        
    }()
    
    var dateFormatterForTime:  DateFormatter {
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.dateFormat = "MMM d, h:mm a"
        return dateFormatterForTime
    }
    
    
    func convertDateToString(date: String) -> String? {
        let newDate = dateformatterToDate.date(from: date)
        return dateformatterToString.string(from: newDate!)
    }
    
    func convertDateToTime(date: String) -> String? {
        let newDate = dateformatterToDate.date(from: date)
        return dateFormatterForTime.string(from: newDate!)
    }
    
}
