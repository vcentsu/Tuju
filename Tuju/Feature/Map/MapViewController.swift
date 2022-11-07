//
//  ViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 11/10/22.
//

import UIKit
import MapKit
import FloatingPanel
import GoogleMaps
import CoreLocation


class MapViewController: UIViewController, GMSMapViewDelegate, PanelViewControllerDelegate {
    
    let mapView = GMSMapView(frame: .zero)
//    let notificationCenter = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    let panel = FloatingPanelController()
    let marker = GMSMarker()
    
    var locations = [Location]()
    
    // Deafault Coordinates View
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(mapView)
        
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.delegate = self
        

        // Set Initial Camera Position
        let camera = GMSCameraPosition.camera(
            withLatitude: coordinateLive.latitude,
            longitude: coordinateLive.longitude,
            zoom: 14.0
        )

        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinateLive.latitude, longitude: coordinateLive.longitude)
        marker.title = "Stasiun Manggarai"
        marker.map = mapView

        mapView.delegate = self
        self.view = mapView
        
        print(GMSServices.openSourceLicenseInfo())
        
        locationManager.requestWhenInUseAuthorization()
//        self.mapView.travelMode = .cycling

        let panelVC = Tuju.PanelViewController()
        panelVC.delegate = self
        
        panel.set(contentViewController: panelVC)
        panel.addPanel(toParent: self)

//        self.view = mapView
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    

    
    func PanelViewController(_ vc: PanelViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else {
            return
        }
        
        panel.move(to: .half, animated: true)
        
        print("UTAMA! \(coordinates)")
        
        let camera = GMSCameraPosition.camera(
                    withLatitude: coordinates.latitude,
                    longitude: coordinates.longitude,
                    zoom: 14.0
        )
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        marker.title = locations.description
        marker.snippet = "Australia"
        marker.map = mapView
        
        self.view = mapView
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let coordinateLive = location.coordinate
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        marker.position = coordinateLive
        marker.map = mapView
    
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
    }
}

