//
//  PoolhallDetailViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 7/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import MapKit

class PoolHallMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource {
    
    @IBOutlet var poolMapView: MKMapView!
    @IBOutlet var poolHallTableView: UITableView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitleToTheLeftWith(title: "PoolHalls")
        poolHallTableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        poolMapView.showsUserLocation = true
        poolMapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath)
        return cell
    }
    
}
