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
import AVFoundation
import UserNotifications
import AudioToolbox.AudioServices

protocol PanelViewControllerDelegate: AnyObject {
    func PanelViewController(didSelectLocationWith coordinates: CLLocationCoordinate2D?)
    func getDataAsal(didSelectLocationWithAsal asalCoordinates: CLLocationCoordinate2D?)
    func getDataTujuan(didSelectLocationWithTujuan tujuanCoordinates: CLLocationCoordinate2D?)
    func refreshPerjalananView()
}

protocol PerjalananViewControllerDelegate: AnyObject {
    func refreshCollectionView()
}


class MapViewController: UIViewController, GMSMapViewDelegate, PanelViewControllerDelegate, UNUserNotificationCenterDelegate{
    
    var myCollection: UICollectionView?
    
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
    
    let panelVC = Tuju.PanelViewController()
    
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
        
        // From Eldwin
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { success, error in
        }
        // mapView.delegate = self
        //let marker = GMSMarker()
        //marker.map = mapView
        //mapView.delegate = self
        // self.view = mapView        

        let nav1 = UINavigationController(rootViewController: Tuju.PanelViewController())
        nav1.viewControllers = [panelVC]
        panel.set(contentViewController: nav1)
        panel.addPanel(toParent: self)
        panelVC.delegate = self // important to update panel -> drawing route on map
       
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")

        let circleCenter = CLLocationCoordinate2D(latitude: -6.209675277806892, longitude: 106.85025771231817)
        let circle = GMSCircle(position: circleCenter, radius: 500)
        circle.map = mapView

        circle.fillColor = UIColor(red: 0.7, green: 0, blue: 0, alpha: 0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 3
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
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        RoutesData.removeFirst()
        nextStationGeofence()
        print("Entered: \(region.identifier)")
        print(region)
//        myCollection?.reloadData()
        panelVC.refreshCollectionView()
        
        print(RoutesData)
        AudioServicesPlaySystemSound(systemSoundID)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

        
        print("Exited: \(region.identifier)")
    }
    

// Anything else to pass from panelVC? else remove this func and its delegation above.
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
            // Point A icon
            //marker.icon = UIImage(systemName: "train.side.rear.car")
            markerTitikA.title = "Asal Anda"
            markerTitikA.snippet = "Asal"
            markerTitikA.map = mapView
            
            markerTitikB = GMSMarker()
            markerTitikB.position = CLLocationCoordinate2DMake(destination.latitude, destination.longitude)
            // Point B icon
            //marker.icon = UIImage(systemName: "train.side.rear.car")
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
                            print(json) // printing all the responses from GoogleMaps API
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
                        print("AMAN")
                    }
                })
            }else {
                if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted{
                    redirectToSettings()
                }
                
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
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

// From Eldwin - current location
        guard let currentlocValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        let newLocation = locations.last
//        let camera = GMSCameraPosition.camera(withLatitude: (newLocation?.coordinate.latitude)!, longitude: (newLocation?.coordinate.longitude)!, zoom: 15.0)
//        self.mapView.animate(to: camera)
        let lat  = (newLocation?.coordinate.latitude)! // get current location latitude
        let long = (newLocation?.coordinate.longitude)! //get current location longitude

        marker.position = CLLocationCoordinate2DMake(lat, long)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        marker.icon = UIImage(systemName: "train.side.rear.car")

        DispatchQueue.main.async {
            self.marker.map = self.mapView  // Setting marker on mapview in main thread.
        }

        for currentLocation in locations{
            print("\(index): \(locations)")
            "0: [locations]"
        }
    }
}

extension MapViewController{
    func refreshPerjalananView() {
        //perintahkan Panel untuk perintahkan PerjalananView untuk refresh CollectionView

    }
}

func addDestinationGeofence(){
    UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]) { success, error in
        }
    let manager = CLLocationManager()
    //GEOFENCE AND ALERT DESTINATION
    if (RoutesData.count > 2){
        var tujuan = RoutesData.last
        let geoFenceDestination: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(tujuan?.latitude ?? 0, tujuan?.longitude ?? 0), radius: 100, identifier: "\(tujuan?.namaStasiun ?? "")")
        manager.startMonitoring(for: geoFenceDestination)
        geoFenceDestination.notifyOnEntry = true
        geoFenceDestination.notifyOnExit = false
        let destinationTrigger = UNLocationNotificationTrigger(region: geoFenceDestination, repeats: true)
        
        let contentDestination = UNMutableNotificationContent()
        contentDestination.title = "Bersiap-siap! Stasiun Berikutnya Adalah Tujuan Kamu"
        contentDestination.body = "Bersiap menuju ke pintu keluar, tujuanmu di stasiun berikutnya, \(tujuan!.namaStasiun)"
        contentDestination.sound = UNNotificationSound.default
        
        let Destinationid = UUID().uuidString
        let Destinationrequest = UNNotificationRequest(identifier: Destinationid, content: contentDestination, trigger: destinationTrigger)
        
        vibrateThreeTimes()
        
        UNUserNotificationCenter.current().add(Destinationrequest) { error in
            if let error = error {
                // handle error
                
            }
        }
    }
    else if (RoutesData.count > 2){
        var destinationGeo = RoutesData[RoutesData.count-2]
        var tujuan = RoutesData.last
        let geoFenceDestination: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(destinationGeo.latitude ?? 0, destinationGeo.longitude ?? 0), radius: 100, identifier: "\(destinationGeo.namaStasiun ?? "")")
        manager.startMonitoring(for: geoFenceDestination)
        geoFenceDestination.notifyOnEntry = true
        geoFenceDestination.notifyOnExit = false
        let destinationTrigger = UNLocationNotificationTrigger(region: geoFenceDestination, repeats: true)
        
        let contentDestination = UNMutableNotificationContent()
        contentDestination.title = "Bersiap-siap! Stasiun Berikutnya Adalah Tujuan Kamu"
        contentDestination.body = "Bersiap menuju ke pintu keluar, tujuanmu di stasiun berikutnya, \(tujuan!.namaStasiun)"
        contentDestination.sound = UNNotificationSound.default
        
        let Destinationid = UUID().uuidString
        let Destinationrequest = UNNotificationRequest(identifier: Destinationid, content: contentDestination, trigger: destinationTrigger)
        
        vibrateThreeTimes()
        
        UNUserNotificationCenter.current().add(Destinationrequest) { error in
            if let error = error {
                // handle error
                
            }
        }
    }
}

func nextStationGeofence(){
    let manager = CLLocationManager()
    //GEOFENCE AND ALERT DESTINATION
    if(RoutesData.count>2){
        let geoFencenNextStation: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(RoutesData[1].latitude ?? 0, RoutesData[1].longitude ?? 0), radius: 300, identifier: "\(RoutesData[1].namaStasiun ?? "")")
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
            
            vibrateTwice()
            
            UNUserNotificationCenter.current().add(TanahAbangrequest) { error in
                if let error = error {
                    // handle error
                    
                }
            }
        }
        
        if(RoutesData[1].namaStasiun == "Manggarai"){
            let manggaraiTrigger = UNLocationNotificationTrigger(region: geoFencenNextStation, repeats: true)
            
            let contentManggarai = UNMutableNotificationContent()
            contentManggarai.title = "You Will Arrive At \(geoFencenNextStation.identifier)"
            contentManggarai.body = "Prepare yourself! You will arrive at \(geoFencenNextStation.identifier)"
            contentManggarai.sound = UNNotificationSound.default
            
            let Manggaraiid = UUID().uuidString
            let Manggarairequest = UNNotificationRequest(
                identifier: Manggaraiid, content: contentManggarai, trigger: manggaraiTrigger)
            
            vibrateTwice()
            
            UNUserNotificationCenter.current().add(Manggarairequest) { error in
                if let error = error {
                    // handle error
                }
            }
        }
        
        print(geoFencenNextStation)
    }
}
