//
//  Regions.swift
//  worldRegionss
//
//  Created by Usha Natarajan on 8/30/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation
import MapKit

enum Regions:String{
    case europe = "Europe"
    case asia = "Asia"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case oceania = "Oceania"
    case africa = "Africa"
    case antarctica = "Antarctica"
    
    var description: String{
        switch self {
        case .europe:
            return Regions.europe.rawValue
        case .asia:
            return Regions.asia.rawValue
        case .northAmerica:
            return Regions.northAmerica.rawValue
        case .southAmerica:
            return Regions.southAmerica.rawValue
        case .oceania:
            return Regions.oceania.rawValue
        case .africa:
            return Regions.africa.rawValue
        case .antarctica:
            return Regions.antarctica.rawValue
        }
    }
    
    var coordinates:CLLocation{
        switch self {
        case .europe:
            return CLLocation(latitude:54.5260 ,longitude:15.2551)
        case .asia:
            return CLLocation(latitude:34.0479 ,longitude:100.6197)
        case .northAmerica:
            return CLLocation(latitude:54.5260 ,longitude:-105.2551)
        case .southAmerica:
            return CLLocation(latitude:-8.7832 , longitude:-55.4915)
        case .oceania:
            return CLLocation(latitude:-25.2744 ,longitude:133.7751)
        case .africa:
            return CLLocation(latitude:-8.7832 ,longitude:34.5085)
        case .antarctica:
            return CLLocation(latitude:-82.8628 ,longitude:135.0000)
        }
    }
    
    var Political:[Subregions]{
        switch self {
            case .europe:
                return [Subregions.northEurope,
                    Subregions.westEurope,
                    Subregions.eastEurope,
                    Subregions.southernEurope]
            case .asia:
                return [Subregions.eastAsia ,
                    Subregions.westAsia ,
                    Subregions.centralAsia,
                    Subregions.southAsia,
                    Subregions.southEastAsia]
            case .northAmerica:
                return [Subregions.northAmerica,
                        Subregions.caribbean,
                        Subregions.centralAmerica]
            case .southAmerica:
                return [Subregions.andeanStates,
                        Subregions.southernCone,
                        Subregions.brazil,
                        Subregions.guayanas]
            case .oceania:
                return [Subregions.australiaNewzealand,
                        Subregions.polynesia,
                    Subregions.melanesia,
                    Subregions.micronesia]
            case .africa:
                return [Subregions.northAfrica,
                        Subregions.westAfrica,
                        Subregions.eastAfrica,
                        Subregions.centralAfrica,
                        Subregions.southernAfrica]
            case .antarctica:
                return [Subregions.polar]
        }
    }
}//end of Regions


