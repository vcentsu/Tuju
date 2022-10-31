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
    
    let panel = FloatingPanelController()
    
    // MapKit
    let mapView2 = MKMapView()
    
    @IBOutlet weak var mapView: GMSMapView!
    let manager = CLLocationManager()
    let marker = GMSMarker()
        
    // Setting manggarai as default station
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
//        self.mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinateLive.latitude, longitude: coordinateLive.longitude, zoom: 13.0)
        
        // Testing
//            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//            self.view.addSubview(mapView)
//
            
        // Section
              guard let map = mapView else {return}
              map.animate(toLocation: coordinateLive)
              map.camera = camera
              map.animate(to: camera)
              
              let searchVC = Tuju.PanelViewController()
              searchVC.delegate = self
              
              panel.set(contentViewController: searchVC)
              panel.addPanel(toParent: self)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let map = mapView else {return}
        map.frame = view.bounds
    }
    
    func PanelViewController(_ vc: PanelViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else {
            return
        }

        panel.move(to: .hidden, animated: true)
        
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

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        coordinateLive = location.coordinate
        
        guard let map = mapView else {
            return
        }
        
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        
        marker.position = coordinateLive
        marker.map = map
    
//        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
    }
}

