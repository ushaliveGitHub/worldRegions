//
//  CountriesViewController.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/4/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import UIKit
import MapKit

class CountriesViewController: UIViewController,CollapsibleHeaderViewDelegate {
    
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var countryMapView: MKMapView!
    
    struct Storyboard{
        static let countryDetailCell = "CountryDetailCell"
    }
    
    var countries:[Country] = []
    var location = LocationType.continent
    var locationName:String!
    var noPin:Bool = false
    var pin:Pin?
    var pins:[MKAnnotation] = []
    var tempCoordinate:Coordinate?
    var coordinate:Coordinate?{
        didSet{
           
            self.countryMapView.setCenterCoordinate(centerCoordinate:CLLocationCoordinate2D(latitude:(self.coordinate?.latitude)!,longitude:(self.coordinate?.longitude)!), zoomLevel:0.0, animated:true)
            self.countryMapView.addPin(title: locationName, coordinate: CLLocationCoordinate2D(latitude:(self.coordinate?.latitude)!,longitude:(self.coordinate?.longitude)!),pins:&pins,noPin:&noPin,location: location)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.countriesTableView.layer.borderColor = UIColor.white.withAlphaComponent(1.0).cgColor
        self.countriesTableView.layer.borderWidth = 2.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = countries[0].subregion
        coordinate = tempCoordinate!
        location = LocationType.country
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleSection(header: CollapsibleHeaderView, section: Int) {
        countries[section].expanded = !countries[section].expanded //toggle
        countriesTableView.beginUpdates()
        header.setCollapsed(collapsed: countries[section].expanded)
        for i in 0 ..< 1{
            countriesTableView.reloadRows(at: [IndexPath(row:i,section:section)], with:.automatic)
        }
        countriesTableView.endUpdates()
        
        //update countryMapView
        if countries[section].expanded{
            if !countries[section].pinned{
                locationName = countries[section].name
                countries[section].pinned = true
            }else{
                noPin = true
            }
            coordinate = Coordinate(location: CLLocation(latitude:countries[section].latlng.0,longitude:countries[section].latlng.1))
        }
 
    }//end of toggleSection
    
}//end of countriesTableViewController


//MARK: For tableView Delegate and Data Source
extension CountriesViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }//end of numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }//end of numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if countries[indexPath.section].expanded{
            return 68
        }else{
            return 0
        }
    }//end of heightForRowAt
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }//end of heightForHeaderInSection
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2 //to separate various sections
    }//end of heightForFooterInSection
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CollapsibleHeaderView()
        header.customInit(title: countries[section].name, expanded: countries[section].expanded ,section: section, delegate: self)
        return header
    }//end viewForHeaderInSection

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = countriesTableView.dequeueReusableCell(withIdentifier:Storyboard.countryDetailCell, for: indexPath) as! CountryTableViewCell
        let country = self.countries[indexPath.section]
        countryCell.country = country
        return countryCell
    }//end of cellForRowAt
    
}//end of extension 1 for CountriesViewController

//MARK: Extension for countryMapViewDelegate
extension CountriesViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? Pin{
            let identifier = "locationPin"
            var pinView:MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                pinView = dequeuedView
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView.canShowCallout = true
            }
            pinView.pinTintColor = annotation.pinTintColor()
            return pinView
        }
        return nil
    }//end of viewFor annotation    
}//end of extension for MKMapViewDelegate


