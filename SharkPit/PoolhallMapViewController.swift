//
//  PoolhallDetailViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 7/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import MapKit

class PoolHallMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet var poolMapView: MKMapView!
    @IBOutlet var poolHallTableView: UITableView!
    var resultSearchController:UISearchController? = nil
    var locationManager = CLLocationManager()
    let poolHallVC = PoolHallMapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poolHallTableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        poolMapView.showsUserLocation = true
        poolMapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        resultSearchController = UISearchController(searchResultsController: poolHallVC)
        resultSearchController?.searchResultsUpdater = poolHallVC
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath)
        //        let business = businessList.business[indexPath.row]
        //        cell.textLabel?.text = business.name
        //        cell.detailTextLabel?.text = business.location
        //        cell.textLabel?.text = testArray[indexPath.row]
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    
    }
    
}
