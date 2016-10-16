//
//  UserLocation.swift
//  SharkPit
//
//  Created by Tyler Jasper on 9/5/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

//import Foundation
//import CoreLocation
//
//class UserLocation: NSObject, CLLocationManagerDelegate {
//    
//    internal class UserLocationManager: NSObject, CLLocationManagerDelegate {
//        
//        var locationManager: CLLocationManager = CLLocationManager()
//        
//        var latitude: Double!
//        var longitude: Double!
//        
//        private var requested: Bool = false
//        
//        func requestLocation() {
//            if self.requested {
//                return
//            }
//            self.locationManager.delegate = self
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            self.locationManager.requestWhenInUseAuthorization()
//            self.locationManager.startUpdatingLocation()
//            self.requested = true
//        }
//        
//        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//            print("error = \(error)")
//        }
//        
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            let location = locations.last
//            if location?.horizontalAccuracy > 0 {
//                self.latitude = location?.coordinate.latitude
//                self.longitude = location?.coordinate.longitude
//                
//                let nc = NotificationCenter.default
//                nc.post(name: "UserLocation/updated" as NSNotification.Name, object: nil)
//                
//                self.locationManager.stopUpdatingLocation()
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                    self.locationManager.startUpdatingLocation()
//                }
//            }
//        }
//        
//        class var instance: UserLocationManager {
//            struct Static {
//                static let instance: UserLocationManager = UserLocationManager()
//            }
//            return Static.instance
//        }
//        
//    }
//    
//    var manager: UserLocationManager!
//    
//    override init() {
//        manager = UserLocationManager.instance
//    }
//    
//    func requestLocation() {
//        manager.requestLocation()
//    }
//    
//    var latitude: Double {
//        get {
//            return manager.latitude ?? 37.7710347
//        }
//    }
//    
//    var longitude: Double {
//        get {
//            return manager.longitude ?? -122.4040795
//        }
//    }
//    
//    var location: CLLocation {
//        get {
//            return CLLocation(latitude: self.latitude, longitude: self.longitude)
//        }
//    }
//    
//}
