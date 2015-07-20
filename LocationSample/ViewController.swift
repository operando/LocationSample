//
//  ViewController.swift
//  LocationSample
//
//  Created by shinobu okano on 2015/07/20.
//  Copyright (c) 2015年 shinobu okano. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        println(UIDevice.currentDevice().systemName)
        println(UIDevice.currentDevice().systemVersion)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getLocation(sender: AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .Denied:
            NSLog(".Denied")
            break
        case .Restricted:
            NSLog(".Restricted")
            break
        case .NotDetermined:
            if locationManager.respondsToSelector("requestWhenInUseAuthorization") {
//                locationManager.requestWhenInUseAuthorization()
                locationManager.requestAlwaysAuthorization()
            } else {
                locationManager.startUpdatingLocation()
            }
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .Restricted, .Denied:
            manager.stopUpdatingLocation()
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if locations.count > 0 {
            let currentLocation = locations.last as? CLLocation
            NSLog("緯度:\(currentLocation?.coordinate.latitude) 経度:\(currentLocation?.coordinate.longitude)")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error.description)
    }
}

