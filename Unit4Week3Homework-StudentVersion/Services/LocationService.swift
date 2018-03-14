//
//  LocationService.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 3/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    private override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    //singleton
    static var manager = LocationService()
    private var locationManager: CLLocationManager!
}

//MARK: Checking to see if user has or has not authorized location services: Set settings in info.pList
extension LocationService{
    func checkForLocationServices() -> CLAuthorizationStatus{
        var status: CLAuthorizationStatus!
        
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined: //initial state on first launch
                print("user location not detirmined")
            case .denied:
                print("user location denied")
            case .authorizedAlways:
                print("user location always authorized")
            case .authorizedWhenInUse:
                print("user location authorized only when in use")
            default:
                break
            }
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        status = CLLocationManager.authorizationStatus()
        return status
    }
}


extension LocationService: CLLocationManagerDelegate{
    //Executed everytime a location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocation = locations.last else {print("no location data"); return }
        print("didUpdateLocations: \(locations)")
        let coordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        //Update User Preferences: sets users last location as the location when you open the app back up
        //UserDefaultsHelper.manager.setLatitude(latitude: userLocation.coordinate.latitude)
        //UserDefaultsHelper.manager.setLongitude(longitude: userLocation.coordin
    }
}

