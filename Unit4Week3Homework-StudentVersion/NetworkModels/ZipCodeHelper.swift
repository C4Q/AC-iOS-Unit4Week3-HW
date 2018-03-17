//
//  ZipCodeHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import CoreLocation

class ZipCodeHelper {
    private init() {}
    static let manager = ZipCodeHelper()
    
    func getLocationName(from zipCode: String,
                         completionHandler: @escaping (String) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        
        let geocoder = CLGeocoder() // An interface for converting between geographic coordinates and place names.
        
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let name = placemark.locality {
                        completionHandler(name)
                    } else if let error = error{
                        errorHandler(error)
                    }
                }
            }
        }
    }
}

//    func getLocationName(from coordinates: CLLocation,
//                         completionHandler: @escaping (String) -> Void,
//                         errorHandler: @escaping (Error) -> Void) {
//
//        let geocoder = CLGeocoder() // An interface for converting between geographic coordinates and place names.
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            geocoder.reverseGeocodeLocation(coordinates, completionHandler: { (placeMarks, error) in
//                DispatchQueue.main.async {
//                    if let placemark = placeMarks?.first, let name = placemark.locality {
//                        completionHandler(name)
//                    } else if let error = error{
//                        errorHandler(error)
//                    }
//                }
//            })
//        }
//    }

