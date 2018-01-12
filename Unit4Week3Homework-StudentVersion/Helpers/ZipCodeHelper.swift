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
    func getLocationName(from zipCode: String, completionHandler: @escaping (String) -> Void, errorHandler: @escaping (Error) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let name = placemark.locality {
                        completionHandler(name)
                    } else {
                        print(error?.localizedDescription ?? "")
                    }
                }
            }
        }
    }
}
