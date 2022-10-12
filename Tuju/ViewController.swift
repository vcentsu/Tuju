//
//  ViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 11/10/22.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let manager = CLLocationManager()
    let marker = GMSMarker()
        
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        self.mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinateLive.latitude, longitude: coordinateLive.longitude, zoom: 16.0)
        mapView.animate(toLocation: coordinateLive)
        mapView.camera = camera
        mapView.animate(to: camera)
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        coordinateLive = location.coordinate
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        marker.position = coordinateLive
        marker.map = mapView
    
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
    }
}

