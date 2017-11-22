//
//  CountryTableViewCell.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/5/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var demonymLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areakm2Label: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    
    var country:Country!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        self.capitalLabel.text = country.capital
        self.demonymLabel.text = country.demonym
        self.populationLabel.text = String(country.population)
        if country.area == 0 {
            self.areakm2Label.text = "Unknown"
        }else{
            self.areakm2Label.text = String(country.area)
        }
        self.continentLabel.text = country.region
        self.regionLabel.text = country.subregion
    }
}//end of CountryTableViewCell
