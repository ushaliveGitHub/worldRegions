//
//  SectionContinent.swift
//  worldRegions
//
//  Created by Usha Natarajan on 8/29/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation

struct Section{
    var continent:Regions!
    var regions:[Subregions]!
    var expanded:Bool!
    var pinned:Bool = false
    
    init(continent:Regions,regions:[Subregions],expanded:Bool){
        self.continent = continent
        self.regions = regions
        self.expanded = expanded
    }
}
