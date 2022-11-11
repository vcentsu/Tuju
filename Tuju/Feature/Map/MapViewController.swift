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
        
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        mapView.delegate = self
        
        let marker = GMSMarker()
        marker.map = mapView
        
        mapView.delegate = self
        self.view = mapView
        

        print(GMSServices.openSourceLicenseInfo())
        
        manager.requestWhenInUseAuthorization()
//        self.mapView.travelMode = .cycling
        let panelVC = Tuju.PanelViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        let nav1 = UINavigationController(rootViewController: Tuju.PanelViewController())
        nav1.viewControllers = [panelVC]
        panelVC.delegate = self
        panel.set(contentViewController: nav1)
        panel.addPanel(toParent: self)
        
//        let panelVC = Tuju.PanelViewController()
//        panelVC.delegate = self
        
        

//        self.view = mapView
        
        let circleCenter = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
        let circle = GMSCircle(position: circleCenter, radius: 500)
        circle.map = mapView
        
        circle.fillColor = UIColor(red: 0.7, green: 0, blue: 0, alpha: 0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 3
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        RoutesData.removeFirst()
        nextStationGeofence()
        print("Entered: \(region.identifier)")
        print(region)
        print(RoutesData)
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

    
    func PanelViewController(didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        print("HALLOMAP")
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

        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        marker.title = locations.description
        marker.snippet = "Australia"
        marker.map = mapView


    }
}

func addDestinationGeofence(){
    UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]) { success, error in
    }
    let manager = CLLocationManager()
    //GEOFENCE AND ALERT DESTINATION
    var destinationGeo = RoutesData.last
    let geoFenceDestination: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(destinationGeo?.latitude ?? 0, destinationGeo?.longitude ?? 0), radius: 100, identifier: "\(destinationGeo?.namaStasiun ?? "")")
    manager.startMonitoring(for: geoFenceDestination)
    geoFenceDestination.notifyOnEntry = true
    geoFenceDestination.notifyOnExit = false
    let destinationTrigger = UNLocationNotificationTrigger(region: geoFenceDestination, repeats: true)
    
    let contentDestination = UNMutableNotificationContent()
    contentDestination.title = "You Will Arrive At \(geoFenceDestination.identifier)"
    contentDestination.body = "Prepare Yourself! You will arrive at your destination, \(geoFenceDestination.identifier)"
    contentDestination.sound = UNNotificationSound.default
    
    let Destinationid = UUID().uuidString
    let Destinationrequest = UNNotificationRequest(identifier: Destinationid, content: contentDestination, trigger: destinationTrigger)
    
    UNUserNotificationCenter.current().add(Destinationrequest) { error in
        if let error = error {
            // handle error
        }
        
        print(geoFenceDestination)
    }
}

func nextStationGeofence(){
    let manager = CLLocationManager()
    //GEOFENCE AND ALERT DESTINATION
    if(RoutesData.count>2){
        let geoFencenNextStation: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(RoutesData[1].latitude ?? 0, RoutesData[1].longitude ?? 0), radius: 100, identifier: "\(RoutesData[1].namaStasiun ?? "")")
        manager.startMonitoring(for: geoFencenNextStation)
        geoFencenNextStation.notifyOnEntry = true
        geoFencenNextStation.notifyOnExit = false
        
        if(RoutesData[1].namaStasiun == "Tanah Abang"){
            let TanahAbangTrigger = UNLocationNotificationTrigger(region: geoFencenNextStation, repeats: true)
            
            let contentTanahAbang = UNMutableNotificationContent()
            contentTanahAbang.title = "You Will Arrive At \(geoFencenNextStation.identifier)"
            contentTanahAbang.body = "Prepare yourself! You will arrive at \(geoFencenNextStation.identifier)"
            contentTanahAbang.sound = UNNotificationSound.default
            
            let TanahAbangid = UUID().uuidString
            let TanahAbangrequest = UNNotificationRequest(
                identifier: TanahAbangid, content: contentTanahAbang, trigger: TanahAbangTrigger)
            
            UNUserNotificationCenter.current().add(TanahAbangrequest) { error in
                if let error = error {
                    // handle error
                }
            }
        }
        
        else if(RoutesData[1].namaStasiun == "Manggarai"){
            let manggaraiTrigger = UNLocationNotificationTrigger(region: geoFencenNextStation, repeats: true)
            
            let contentManggarai = UNMutableNotificationContent()
            contentManggarai.title = "You Will Arrive At \(geoFencenNextStation.identifier)"
            contentManggarai.body = "Prepare yourself! Y    ou will arrive at \(geoFencenNextStation.identifier)"
            contentManggarai.sound = UNNotificationSound.default
            
            let Manggaraiid = UUID().uuidString
            let Manggarairequest = UNNotificationRequest(
                identifier: Manggaraiid, content: contentManggarai, trigger: manggaraiTrigger)

            UNUserNotificationCenter.current().add(Manggarairequest) { error in
                if let error = error {
                    // handle error
                }
            }
        }
        
        print(geoFencenNextStation)
        }
    }


