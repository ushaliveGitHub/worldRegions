//
//  Coordinate.swift
//  worldRegions
//
//  Created by Usha Natarajan on 8/31/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation
import Foundation
import CoreLocation

struct Coordinate: CustomStringConvertible{
    var latitude:Double?
    var longitude:Double?
    
    var description: String{
        return "\(latitude!),\(longitude!)"
    }
    
    init?(location: CLLocation){
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }//end of init
}
