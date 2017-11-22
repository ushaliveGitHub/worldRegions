//
//  Pin.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/5/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//


import UIKit
import MapKit

//
//  Pin.swift
//  locateCapitalCity
//
//  Created by Usha Natarajan on 5/12/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import UIKit
import MapKit

enum serializationError: Error{
    case missing(String)
}// end of enum serializationError

class Pin: NSObject, MKAnnotation {// NSObject is the base class for cocoa apps.
    var title:String?
    var subtitle:String?
    var coordinate:CLLocationCoordinate2D
    var locationType:LocationType
    
    init(title:String,coordinate:CLLocationCoordinate2D,locationType:LocationType){
        self.title = title
        self.coordinate = coordinate
        self.locationType = locationType
        super.init()
    }
    
    func pinTintColor() -> UIColor{
        switch locationType{
        case LocationType.myLocation:
            return UIColor.black
        case LocationType.continent:
            return UIColor.green
        case LocationType.region:
            return UIColor.blue
        case LocationType.country:
            return UIColor.purple
        }
    }//end of func pinTintColor
    
}

