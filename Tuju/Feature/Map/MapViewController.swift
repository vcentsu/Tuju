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
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let manager = CLLocationManager()
    
    let panel = FloatingPanelController()
    
    var locations = [Location]()
    
    let marker = GMSMarker()
    
    // Deafault Coordinates View
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(mapView)
        
        // Do any additional setup after loading the view.
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
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
        let markerCenter = CLLocationCoordinate2D(latitude: coordinateLive.latitude, longitude: coordinateLive.longitude)
        marker.title = "Stasiun Manggarai"
        marker.map = mapView
        
        let markerCircle = GMSCircle(position: markerCenter, radius: 200)
        markerCircle.map = mapView
        markerCircle.fillColor = UIColor(red: 0.0, green: 0, blue: 0.7, alpha: 0.2)
        markerCircle.strokeColor = .blue
        markerCircle.strokeWidth = 3
        
        mapView.delegate = self
        self.view = mapView
        
        print(GMSServices.openSourceLicenseInfo())
        
        manager.requestWhenInUseAuthorization()
//        self.mapView.travelMode = .cycling

        let panelVC = Tuju.PanelViewController()
        panelVC.delegate = self
        
        panel.set(contentViewController: panelVC)
        panel.addPanel(toParent: self)
        
        let circleCenter = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
        let circle = GMSCircle(position: circleCenter, radius: 500)
        circle.map = mapView
        
        circle.fillColor = UIColor(red: 0.7, green: 0, blue: 0, alpha: 0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 3
//        self.view = mapView
    }
    
    //    func startNav() {
    //      var destinations = [GMSNavigationWaypoint]()
    //      destinations.append(GMSNavigationWaypoint.init(placeID: "ChIJmQ6sHHH0aS4R2Kc4sEiEyUc",
    //                                                     title: "Stasiun Manggarai")!)
    //      destinations.append(GMSNavigationWaypoint.init(placeID:"ChIJt_uvMxX0aS4RgasvyQI7DJU",
    //                                                     title:"Stasiun Cikini")!)
    //
    //      mapView.navigator?.setDestinations(destinations) { routeStatus in
    //        self.mapView.navigator?.isGuidanceActive = true
    //        self.mapView.locationSimulator?.simulateLocationsAlongExistingRoute()
    //        self.mapView.cameraMode = .following
    //      }
    //    }
    
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

