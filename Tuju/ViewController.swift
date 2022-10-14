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

class ViewController: UIViewController, GMSMapViewDelegate, SearchViewControllerDelegate {
    
    let panel = FloatingPanelController()
    
    let mapView2 = MKMapView()
    
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
        
        title = "TUJU"
        
        let searchVC = Tuju.SearchViewController()
        searchVC.delegate = self
        
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    func SearchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else {
            return
        }

        panel.move(to: .tip, animated: true)
        
//        mapView.removeFromSuperview(mapView.anchorPoint)
        
        mapView2.removeAnnotations(mapView2.annotations)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView2.addAnnotation(pin)

        mapView2.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(
            latitudeDelta: 0.7,
            longitudeDelta: 0.7
            )
        ), animated: true)
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
    
//        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
    }
}

