//
//  regions.swift
//  worldRegions
//
//  Created by Usha Natarajan on 8/30/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation

enum Subregions:String{
    case eastAsia = "Eastern Asia"
    case westAsia = "Western Asia"
    case centralAsia = "Central Asia"
    case southAsia = "Southern Asia"
    case southEastAsia = "South-Eastern Asia"
    case northAfrica = "Northern Africa"
    case westAfrica = "Western Africa"
    case eastAfrica = "Eastern Africa"
    case centralAfrica = "Central Africa"
    case southernAfrica = "Southern Africa"
    case australiaNewzealand = "Australia and New Zealand"
    case polynesia = "Polynesia"
    case melanesia = "Melanesia"
    case micronesia = "Micronesia"
    case northEurope = "Northern Europe"
    case westEurope = "Western Europe"
    case eastEurope = "Eastern Europe"
    case southernEurope = "Southern Europe"
    case northAmerica = "Northern America"
    case caribbean = "Caribbean"
    case centralAmerica = "Central America"
    case andeanStates = "Andean States"
    case southernCone = "Southern Cone"
    case brazil = "Brazil"
    case guayanas = "Guayanas"
    case polar = "Polar"
    
    var description:String{
        switch self{
        case .eastAsia :
            return "Eastern Asia"
        case .westAsia :
            return "Western Asia"
        case .centralAsia :
            return "Central Asia"
        case .southAsia :
            return "Southern Asia"
        case .southEastAsia :
            return "South-Eastern Asia"
        case .northAfrica :
            return "Northern Africa"
        case .westAfrica :
            return "Western Africa"
        case .eastAfrica :
            return "Eastern Africa"
        case .centralAfrica :
            return "Central Africa"
        case .southernAfrica :
            return "Southern Africa"
        case .australiaNewzealand :
            return "Australia and New Zealand"
        case .polynesia :
            return "Polynesia"
        case .melanesia :
            return "Melanesia"
        case .micronesia :
            return "Micronesia"
        case .northEurope :
            return "Northern Europe"
        case .westEurope :
            return "Western Europe"
        case .eastEurope :
            return "Eastern Europe"
        case .southernEurope :
            return "Southern Europe"
        case .northAmerica :
            return "Northern America"
        case .caribbean :
            return "Caribbean"
        case .centralAmerica :
            return "Central America"
        case .andeanStates :
            return "Andean States"
        case .southernCone :
            return "Southern Cone"
        case .brazil :
            return "Brazil"
        case .guayanas :
            return "Guayanas"
        case .polar :
            return "Polar"
        }
    }
}//end of Subregions
