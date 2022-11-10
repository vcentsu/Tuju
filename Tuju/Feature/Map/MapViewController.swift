//
//  ViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 11/10/22.
//

import UIKit
import FloatingPanel
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
import SwiftyJSON


class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, PanelViewControllerDelegate {
    
    let mapView = GMSMapView(frame: .zero)
//    let notificationCenter = UNUserNotificationCenter.current()
//    let locationManager = CLLocationManager()
//    let panel = FloatingPanelController()
//    let marker = GMSMarker()
    
    // Test
    var locationManager: CLLocationManager!
    var permissionFlag: Bool!
    var currentLocation: CLLocation!
    var googleMaps: GMSMapView!
    var polylineArray: [GMSPolyline] = []
    var origin: CLLocationCoordinate2D!
    var destination: CLLocationCoordinate2D!
    var transferPolyline: String!
    var pickupCoordinate: CLLocationCoordinate2D!
    var geocoder: GMSGeocoder!
    var city: String!
    var address: String!
    let panel = FloatingPanelController()
    let marker = GMSMarker()
    
//    var locations = [Location]()
    
    // Deafault Coordinates View
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        city = ""
        address = ""
        geocoder = GMSGeocoder()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        //view.addSubview(mapView)
//
//        // Do any additional setup after loading the view.
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//        self.mapView.delegate = self
//
//
//        // Set Initial Camera Position
//        let camera = GMSCameraPosition.camera(
//            withLatitude: coordinateLive.latitude,
//            longitude: coordinateLive.longitude,
//            zoom: 14.0
//        )
//
//        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinateLive.latitude, longitude: coordinateLive.longitude)
//        marker.title = "Stasiun Manggarai"
//        marker.map = mapView
//
//        mapView.delegate = self
//        self.view = mapView
//
//        print(GMSServices.openSourceLicenseInfo())
//
//        locationManager.requestWhenInUseAuthorization()
////        self.mapView.travelMode = .cycling
//
        let panelVC = Tuju.PanelViewController()
        panelVC.delegate = self

        panel.set(contentViewController: panelVC)
        panel.addPanel(toParent: self)
//
////        self.view = mapView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.permissionFlag = true
            googleMaps = GMSMapView(frame: self.mapView.frame)
            view.addSubview(googleMaps)
            recenterMaps()
            
        }else{
           self.permissionFlag = false
        }
    }
    
    
    func recenterMaps(){
        //SETTING UP MAPS
        self.pickupCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        if pickupCoordinate != nil{
            
            let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 15.0)
            googleMaps.camera = camera
            googleMaps.mapType = .normal
            geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), completionHandler: {
                response, error in
                if error == nil{
                    if let resultAdd = response?.firstResult(){
                        self.googleMaps.delegate = self
                        let lines = resultAdd.lines! as [String]
                        self.city = resultAdd.locality
                        print("ADDRESS => \(lines.joined(separator: "\n"))")
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
                        marker.snippet = lines.joined(separator: "\n")
                        marker.title = "\(resultAdd.locality ?? "Unavailable")"
                        self.address = lines.joined(separator: "\n")
                        self.drawRoute()
                       // marker.map = self.googleMaps
                    }else{
                        print("ERROR_PLEASE_TRY_AGAIN_LATER")
                    }
                    
                }
            })
            
        }else{
            
            print("CURRENT_LOCATION_OBJECT_IS_NIL")
            
        }
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("EROOR \(error)")
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
            redirectToSettings()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
            
        case .authorizedAlways:
            if manager.location != nil{
                self.permissionFlag = true
                self.currentLocation = manager.location
            }else{

                self.dismiss(animated: true, completion: nil)
                
            }
            break
            
        case .authorizedWhenInUse:
            if manager.location != nil{
                
                self.permissionFlag = true
                self.currentLocation = manager.location
                
            }else{
                
                self.dismiss(animated: true, completion: nil)
                
            }
            break
            
        case .notDetermined:
            self.permissionFlag = false
            redirectToSettings()
            break
            
        case .denied:
            self.permissionFlag = false
            redirectToSettings()
            break
            
        case .restricted:
            self.permissionFlag = false
            redirectToSettings()
            break
            
        default:
            print("ERROR_TRY_AGAIN_LATER")
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
    
    func drawRoute(){
        
        if permissionFlag{
                
//            var stations = [Station]()
            
            let oriLat:Double = manggarai.latitude!
            let oriLong:Double = manggarai.longitude!
            
            let desLat:Double = cikini.latitude!
            let desLong:Double = cikini.longitude!
            
            let origin  = "\(oriLat),\(oriLong)"
            let destination = "\(desLat),\(desLong)"
            
//            let origin  = "\(self.origin.latitude),\(self.origin.longitude)"
//            let destination = "\(self.destination.latitude),\(self.destination.longitude)"
            // drive to train
            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=transit&transit_mode=train&alternatives=false&key=AIzaSyC-gr-6ddyZ_XMEtf7plw4Rlpk61Syo30o"
            
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {
                    Response in
//                    if Response.result.isSuccess {
                if case .success(let value) = Response.result {
                        do{
                            let json =  try JSON(data: Response.data!)
                            let routes = json["routes"].arrayValue
                            print(json)
                            for i in 0 ..< routes.count{
                                let route = routes[i]
                                let routeOverviewPolyline = route["overview_polyline"].dictionary
                                let points = routeOverviewPolyline?["points"]?.stringValue
                                let path = GMSPath.init(fromEncodedPath: points!)
                                let polyline = GMSPolyline.init(path: path)
                                polyline.isTappable = true
                                if i == 0{
                                    polyline.strokeColor = UIColor.blue
                                    polyline.strokeWidth = 5
                                    self.transferPolyline = points // SAVE THESE POINTS THEY ARE ENCODED LAT LONGS OF SUGGESTED ROUTES
                                    if self.googleMaps != nil
                                    {
                                        let bounds = GMSCoordinateBounds(path: path!)
                                        self.googleMaps!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                                    }
                                }else{
                                    polyline.strokeColor = UIColor.lightGray
                                    polyline.strokeWidth = 4
                                }
                                
                                self.polylineArray.append(polyline)
                                polyline.map = self.googleMaps
                            }
                            
                        }catch{
                            print("ERROR")
                        }
                        
                    }else{
                        
                    }
                })
            }else {
            
                if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
                    redirectToSettings()
                }
            
            }
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        if permissionFlag{
            if overlay.isKind(of: GMSPolyline.self){
                mapView.clear()
                for i in 0 ..< self.polylineArray.count{
                    
                    if overlay == polylineArray[i]{
                        if polylineArray[i].strokeColor == UIColor.blue{
                            //ALREADY SELECTED ROUTES
                            print("ALREADY_SELECTED")
                            polylineArray[i].map = mapView
                        }else{
                            //SELECTING ROUTE
                            polylineArray[i].strokeColor = UIColor.blue
                            polylineArray[i].strokeWidth = 5
                            polylineArray[i].map = mapView
                            self.transferPolyline = polylineArray[i].path?.encodedPath()
                            if self.googleMaps != nil
                            {
                                let bounds = GMSCoordinateBounds(path: polylineArray[i].path!)
                                self.googleMaps!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                            }
                            print("TransferPolyline => \(transferPolyline ?? "nil")")
                        }
                    }else{
                        //UNSELECTING ROUTE
                        polylineArray[i].strokeColor = UIColor.lightGray
                        polylineArray[i].strokeWidth = 4
                        polylineArray[i].map = mapView
                    }
                }
            }
        }else{
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
                redirectToSettings()
            }
        }
        
    }
    
    func redirectToSettings(){
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
            self.permissionFlag = false
            let alertController = UIAlertController(title: "Location Access Denied or Restricted",
                                                    message: "Please enable location and try again",
                                                    preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
                if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: { _ in
                        })
                        self.dismiss(animated: true, completion: nil)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.clear()
                    } else {
                        UIApplication.shared.openURL(appSettings as URL)
                        self.dismiss(animated: true, completion: nil)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.clear()
                    }
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                _ in
                self.dismiss(animated: true, completion: {
                    print("DISMISSING_VIEWCONTROLLER")
                })
            })
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    

    
    func PanelViewController(_ vc: PanelViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        
//        guard let coordinates = coordinates else {
//            return
//        }
//
//        panel.move(to: .half, animated: true)
//
//        print("UTAMA! \(coordinates)")
//
//        let camera = GMSCameraPosition.camera(
//                    withLatitude: coordinates.latitude,
//                    longitude: coordinates.longitude,
//                    zoom: 14.0
//        )
//
//        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        marker.title = locations.description
//        marker.snippet = "Australia"
//        marker.map = mapView
//
//        self.view = mapView
    }
}

//extension MapViewController: CLLocationManagerDelegate{
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        
//        let coordinateLive = location.coordinate
//        
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        
//        marker.position = coordinateLive
//        marker.map = mapView
//    
//        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
//    }
//}

