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
import GooglePlaces
import CoreLocation
import Alamofire
import SwiftyJSON

protocol PanelViewControllerDelegate: AnyObject {
    func PanelViewController(didSelectLocationWith coordinates: CLLocationCoordinate2D?)
    func getDataAsal(didSelectLocationWithAsal asalCoordinates: CLLocationCoordinate2D?)
    func getDataTujuan(didSelectLocationWithTujuan tujuanCoordinates: CLLocationCoordinate2D?)
}

class MapViewController: UIViewController, GMSMapViewDelegate, PanelViewControllerDelegate {
    
    var locationManager: CLLocationManager!
    var permissionFlag: Bool!
    var currentLocation: CLLocation!
    var mapView = GMSMapView(frame: .zero)
    var polylineArray: [GMSPolyline] = []
    var origin: CLLocationCoordinate2D!
    var destination: CLLocationCoordinate2D!
    var transferPolyline: String!
    var pickupCoordinate: CLLocationCoordinate2D!
    var geocoder: GMSGeocoder!
    var city: String!
    var address: String!
    var markerTitikA = GMSMarker()
    var prevTitikA: CLLocationCoordinate2D!
    var markerTitikB = GMSMarker()
    var prevTitikB: CLLocationCoordinate2D!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let panel = FloatingPanelController()
    
    var locations = [Location]()
    
    let marker = GMSMarker()
    
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
        
        //Set default map
        recenterMaps()
        
        let panelVC = Tuju.PanelViewController() //ViewController = Name of your controller
        let nav1 = UINavigationController(rootViewController: Tuju.PanelViewController())
        nav1.viewControllers = [panelVC]
        panelVC.delegate = self
        panel.set(contentViewController: nav1)
        panel.addPanel(toParent: self)
        
//        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    func recenterMaps(){
        
        self.permissionFlag = true
        self.currentLocation = locationManager.location
        
        // Set Initial Camera Position
        self.pickupCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        
        if pickupCoordinate != nil{
            
            //Set Camera Position
            let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 14.0)
            mapView.camera = camera
            mapView.mapType = .normal
            geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), completionHandler: {
                response, error in
                if error == nil{
                    if let resultAdd = response?.firstResult(){
                        self.mapView.delegate = self
                        let lines = resultAdd.lines! as [String]
                        self.city = resultAdd.locality
                        print("ADDRESS RECENTER MAP => \(lines.joined(separator: "\n"))")

                    }else{
                        print("ERROR_PLEASE_TRY_AGAIN_LATER")
                    }
                }
            })
        }else{
            print("CURRENT_LOCATION_OBJECT_IS_NIL")
        }

        self.view = mapView
     
    }
    
    func PanelViewController(didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
//        panel.move(to: .half, animated: true)
        
    }
    
    
    
    func getDataAsal(didSelectLocationWithAsal asalCoordinates: CLLocationCoordinate2D?) {
        markerTitikA.map?.clear()
        print("getDataAsal")

        guard let asalCoordinates = asalCoordinates else {
            return
        }

        let camera = GMSCameraPosition.camera(
            withLatitude: asalCoordinates.latitude,
            longitude: asalCoordinates.longitude,
            zoom: 14.0
        )
        mapView.camera = camera

        print("Asal: \(asalCoordinates)")

        origin = asalCoordinates
        mapView.clear()
        drawRoute()
    }
    
    func getDataTujuan(didSelectLocationWithTujuan tujuanCoordinates: CLLocationCoordinate2D?) {
        
        markerTitikB.map?.clear()
        print("getDataTujuan")
        
        guard let tujuanCoordinates = tujuanCoordinates else {
            return
        }
        
        let camera = GMSCameraPosition.camera(
            withLatitude: tujuanCoordinates.latitude,
            longitude: tujuanCoordinates.longitude,
            zoom: 14.0
        )
        
        mapView.camera = camera
        
        
        print("Tujuan: \(tujuanCoordinates)")
        
        destination = tujuanCoordinates
        mapView.clear()
        drawRoute()
    }
    
    // Drawing Map
    func drawRoute() {
        
        if (destination != nil) && (origin != nil) {
           
            markerTitikA = GMSMarker()
            markerTitikA.position = CLLocationCoordinate2DMake(origin.latitude, origin.longitude)
//            marker.icon = UIImage(systemName: "train.side.rear.car")
            markerTitikA.title = "Asal Anda"
            markerTitikA.snippet = "Asal"
            markerTitikA.map = mapView
            
            markerTitikB = GMSMarker()
            markerTitikB.position = CLLocationCoordinate2DMake(destination.latitude, destination.longitude)
//            marker.icon = UIImage(systemName: "train.side.rear.car")
            markerTitikB.title = "Tujuan Anda"
            markerTitikB.snippet = "Tujuan"
            markerTitikB.map = mapView
            
            print("Drawing on the map!")
            if permissionFlag{
                
                let origin  = "\(origin.latitude),\(origin.longitude)"
                let destination = "\(destination.latitude),\(destination.longitude)"
                
                
                let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=transit&transit_mode=train&alternatives=false&key=AIzaSyC-gr-6ddyZ_XMEtf7plw4Rlpk61Syo30o"
                
                AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {
                    Response in
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
                                    polyline.strokeColor = UIColor.orange
                                    polyline.strokeWidth = 6
                                    self.transferPolyline = points // SAVE THESE POINTS THEY ARE ENCODED LAT LONGS OF SUGGESTED ROUTES
                                    if self.mapView != nil
                                    {
                                        let bounds = GMSCoordinateBounds(path: path!)
                                        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                                    }
                                }else{
                                    polyline.strokeColor = UIColor.lightGray
                                    polyline.strokeWidth = 4
                                }
                                
                                self.polylineArray.append(polyline)
                                polyline.map = self.mapView
                            }
                            
                        }catch{
                            print("ERROR")
                        }
                        
                    }else{
                        
                    }
                })
            }else {
                
                if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
                    //                redirectToSettings()
                }
                
            }
        }
        
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
        marker.icon = UIImage(systemName: "train.side.rear.car")
        marker.map = mapView
        
// UJICOBA MAP
//        mapView.animate(toZoom: 12)
//        let zoomCamera = GMSCameraUpdate.zoomIn()
//        mapView.animate(with: zoomCamera)
//        let downwards = GMSCameraUpdate.scrollBy(x: 0, y: 100)
//        mapView.animate(with: downwards)
//        mapView.animate(toViewingAngle: 45)
//        print("Updating current location")
    }
}
