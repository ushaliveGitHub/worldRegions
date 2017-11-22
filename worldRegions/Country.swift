//
//  Country.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/2/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation

struct Country{
    var name:String
    var capital:String
    var demonym:String
    var region:String
    var subregion:String
    var population:Int64
    var area: Int64
    var latlng:(Double,Double)
    var expanded:Bool = false
    var pinned:Bool = false
    
    init?(json: [String : Any]){
        guard let name = json["name"] as? String,
        let capital = json["capital"] as? String,
        let demonym = json["demonym"] as? String,
        let region = json["region"] as? String,
        let subregion = json["subregion"] as? String,
        let population = json["population"] as? Int64,
        let area = json["area"] as? Int64,
        let latlng = json["latlng"] as? [Double] else{
                return nil
        }
        self.name = name
        self.capital = capital
        self.demonym = demonym
        self.region = region
        self.subregion = subregion
        self.population = population
        self.area = area
        self.latlng.0 = latlng[0]
        self.latlng.1 = latlng[1]
    }//end of failable initializer
}
