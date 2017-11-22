//
//  ViewController.swift
//  worldRegions
//
//  Created by Usha Natarajan on 8/29/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import UIKit
import MapKit

class RegionsViewController: UIViewController,CollapsibleHeaderViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var worldTableView: UITableView!
    
    typealias JSON = [String : Any]
    typealias JSONHandler = (JSON?, Error?)->Void
    
    
    struct Storyboard{
        static let segueCountries = "Countries"
        static let subRegionCell = "SubRegionCell"
    }
    
    var countries:[Country] = []{
        didSet{
            // add code later
        }
    }
    var selectedSubRegion:Subregions?
    var selectedRegion:Regions?
   
    var err:Error? = nil
    var defaultLatitude = 40.7128
    var defaultLongitude = -74.0059
    var locationManager = LocationManager()
    var location = LocationType.myLocation
    var locationName:String = "Your Location"
    var noPin:Bool = true
    var pin:Pin?
    var pins:[MKAnnotation] = []
    var coordinate:Coordinate?{
        didSet{
            self.mapView.setCenterCoordinate(centerCoordinate:CLLocationCoordinate2D(latitude:(self.coordinate?.latitude)!,longitude:(self.coordinate?.longitude)!), zoomLevel:0.0, animated:true)
            self.mapView.addPin(title: locationName, coordinate: CLLocationCoordinate2D(latitude:(self.coordinate?.latitude)!,longitude:(self.coordinate?.longitude)!),pins:&pins,noPin:&noPin,location: location)
        }
    }
    
    var sections = [
        Section(continent:Regions.africa,regions:Regions.africa.Political,expanded:false),
        Section(continent:Regions.asia,regions:Regions.asia.Political,expanded:false),
        Section(continent:Regions.europe,regions:Regions.europe.Political,expanded:false),
        Section(continent:Regions.northAmerica,regions:Regions.northAmerica.Political,expanded:false),
        Section(continent:Regions.southAmerica,regions:Regions.southAmerica.Political,expanded:false),
        Section(continent:Regions.oceania,regions:Regions.oceania.Political,expanded:false),
        Section(continent:Regions.antarctica,regions:Regions.antarctica.Political,expanded:false)]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.worldTableView.layer.borderColor = UIColor.white.withAlphaComponent(1.0).cgColor
        self.worldTableView.layer.borderWidth = 2.0
    }//end of viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load world data from json into Countries
        loadWorldData{ (result:Result)->Void in
            switch result{
            case .success(let countries):
                self.countries = countries as! [Country]
            case .failure(let error):
                self.err = error
                print("App encountered:\(error)")
                return
            }
        }

        //Get current user device coordinates
        if let _ = coordinate{
            //do nothing
        }else{//set a default value
                self.coordinate = Coordinate(location:CLLocation(latitude: defaultLatitude , longitude: defaultLongitude))
        }
        
        locationManager.getPermission()
        locationManager.didGetLocation = { [weak self] coordinate in
            self?.coordinate = coordinate
        }
    }//end of viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.segueCountries{
            let countriesViewController = segue.destination as! CountriesViewController
            countriesViewController.countries = self.countries.filter {
                return $0.subregion == selectedSubRegion?.description
            }
            countriesViewController.locationName = selectedRegion?.description
            countriesViewController.tempCoordinate = Coordinate(location:(selectedRegion?.coordinates)!)
        }
    }//end of prepare for segue
    
    //Trigger  the Toggle arrow and update the rows
    func toggleSection(header: CollapsibleHeaderView, section: Int) {
        
        sections[section].expanded = !sections[section].expanded //toggle
        worldTableView.beginUpdates()//start updating rows
        header.setCollapsed(collapsed: sections[section].expanded)
        for i in 0 ..< sections[section].regions.count{
            worldTableView.reloadRows(at: [IndexPath(row:i,section:section)], with:.automatic)
        }
        worldTableView.endUpdates()
        
        //update MapView
        if sections[section].expanded{
            if !sections[section].pinned{
                locationName = sections[section].continent.description
                location = LocationType.continent
                sections[section].pinned = true
            }else{
                noPin = true
            }
            coordinate = Coordinate(location: sections[section].continent.coordinates)
        }
    }
}//end of ViewController


//MARK: For Table View

extension RegionsViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].regions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded{
            return 44
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
        header.customInit(title: sections[section].continent.description, expanded: sections[section].expanded ,section: section, delegate: self)
        return header
    }//end viewForHeaderInSection
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worldTableView.dequeueReusableCell(withIdentifier: Storyboard.subRegionCell)!
        cell.textLabel?.text = sections[indexPath.section].regions[indexPath.row].description
        return cell
    }//end of cellForRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if err != nil{
            let alertVC = UIAlertController(title: "Encountered Error", message:err?.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        selectedSubRegion = sections[indexPath.section].regions[indexPath.row]
        if selectedSubRegion == Subregions.polar{
            return
        }
        selectedRegion = sections[indexPath.section].continent
        self.performSegue(withIdentifier: Storyboard.segueCountries,sender: self)
    }
}//end of extension 1 for ViewController


//MARK: Extension for MapViewDelegate
extension RegionsViewController:MKMapViewDelegate {
    
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

