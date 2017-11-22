//
//  LocationManager.swift
//  weatherforecast
//
//  Created by Usha Natarajan on 6/27/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import Foundation
import CoreLocation //for location Services

class LocationManager:NSObject{
    
    let manager = CLLocationManager()
    var didGetLocation:((Coordinate)->Void)?
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }//end of init
    
    func getPermission(){ // get location service permission from user
        if CLLocationManager.authorizationStatus() == .notDetermined{
            manager.requestWhenInUseAuthorization()
        }
    }//end of getPersmission
}//end of LocationManager

extension LocationManager : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            manager.requestLocation()
        }
    }//end of location manager with did change authorization status
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription): Cannot determine location,using default location.")
    }//end of did fail with Error
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
        }
        let coordinate = Coordinate(location: location)
        if let didGetLocation = didGetLocation {
            didGetLocation(coordinate!)
        }
    }
}//end of Location Manager extension



