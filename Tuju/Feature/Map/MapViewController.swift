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
import AVFoundation
import UserNotifications

class MapViewController: UIViewController, GMSMapViewDelegate, UNUserNotificationCenterDelegate{
    
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
        
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { success, error in
        }
        
        let content = UNMutableNotificationContent()
        content.title = "You Will Arrive At Your Destination"
        content.body = "You will arrive at ..."
        
        
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        mapView.delegate = self
        
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(-6.209675277806892, 106.85025771231817), radius: 100, identifier: "Manggarai")
        manager.startMonitoring(for: geoFenceRegion)
        geoFenceRegion.notifyOnEntry = true
        geoFenceRegion.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: geoFenceRegion, repeats: true)
        
        let id = UUID().uuidString
        let request = UNNotificationRequest(
            identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                // handle error
            }
        }

        let marker = GMSMarker()
        marker.map = mapView
        
        mapView.delegate = self
        self.view = mapView
        

        let panelVC = Tuju.PanelViewController()
        
        panel.set(contentViewController: panelVC)
        panel.addPanel(toParent: self)
        
        let circleCenter = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
        let circle = GMSCircle(position: circleCenter, radius: 500)
        circle.map = mapView
        
        circle.fillColor = UIColor(red: 0.7, green: 0, blue: 0, alpha: 0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 3
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered: \(region.identifier)")
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentlocValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        let newLocation = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (newLocation?.coordinate.latitude)!, longitude: (newLocation?.coordinate.longitude)!, zoom: 15.0)
        self.mapView.animate(to: camera)
        let lat  = (newLocation?.coordinate.latitude)! // get current location latitude
        let long = (newLocation?.coordinate.longitude)! //get current location longitude
        
        marker.position = CLLocationCoordinate2DMake(lat, long)
        
        DispatchQueue.main.async {
            self.marker.map = self.mapView  // Setting marker on mapview in main thread.
        }
        
        for currentLocation in locations{
            print("\(index): \(locations)")
            //"0: [locations]"
        }
    }
}

