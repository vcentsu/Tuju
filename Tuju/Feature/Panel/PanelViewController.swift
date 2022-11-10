//
//  SearchViewController.swift
//  Searching-Locations-iOS
//
//  Created by Ulul I. on 05/10/22.
//

import UIKit
import FloatingPanel
import GoogleMaps
import CoreLocation

protocol PanelViewControllerDelegate: AnyObject {
    func PanelViewController(_ vc: PanelViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}

class PanelViewController: UIViewController, UITextFieldDelegate, AsalEntryViewControllerDelegate {
    
    let panel = FloatingPanelController()
    
    var sourceCordinate: CLLocationCoordinate2D!
    var destinationCordinate: CLLocationCoordinate2D!
    var locationManager: CLLocationManager!
    
    weak var delegate: PanelViewControllerDelegate?
    
    var locations = [Location]()
    
    let mapView = GMSMapView(frame: .zero)
    
    var sourceTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Asal: Pilih Stasiun Asal"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        
        return field
    }()
    
    var destinationTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Tujuan: Pilih Stasiun Tujuan"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        
        return field
    }()
    
    
    let startBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 20
        button.setTitle("Mulai Perjalanan", for: .normal)
        button.addTarget(AsalEntryViewController.self, action: #selector(didTapMulai), for: .touchUpInside)
        
        return button
    }()
    
    private let label: UILabel = {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "info.circle.fill")
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " Mulai perjalanan saat berada di stasiun awal")
        imageString.append(textString)
        let label = UILabel()
        label.attributedText = imageString
        label.font = .systemFont(ofSize: 14, weight: .ultraLight)
        
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        //Asal
        view.addSubview(sourceTextfield)
        sourceTextfield.addTarget(self, action: #selector(didTapAsal), for: .touchUpInside)
        sourceTextfield.delegate = self
    
        //Tujuan
        view.addSubview(destinationTextfield)
        destinationTextfield.addTarget(self, action: #selector(didTapTujuan), for: .touchUpInside)
        destinationTextfield.delegate = self
    
        
        view.addSubview(label)
        view.addSubview(startBtn)

        let asalVC = Tuju.AsalEntryViewController()
        asalVC.delegate = self
        
//        panel.set(contentViewController: asalVC)
//        panel.addPanel(toParent: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        sourceTextfield.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 50)
        destinationTextfield.frame = CGRect(x: 20, y: 40+sourceTextfield.frame.size.height, width: view.frame.size.width-40, height: 50)

        label.sizeToFit()
        label.frame = CGRect(x: 25, y: 120+destinationTextfield.frame.size.height, width: label.frame.size.width, height: label.frame.size.height)
        startBtn.frame = CGRect(x: 20, y: 180+label.frame.size.height, width: view.frame.size.width-40, height: 50)
        mapView.frame = view.bounds
    }
    
    @objc private func didTapMulai() {
        // Draw the direction
        panel.move(to: .tip, animated: true)
        Departure = self.sourceTextfield.text!
        Destination = self.destinationTextfield.text!
        RoutesLogic()
        FavAndRecentLogic()
        print(recentData)
        print(favoriteData)
        print(TransitStation)
        print(RoutesData)
        print(numberOfTransit)
        
        if sourceCordinate != nil && destinationCordinate != nil{
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            VC.origin = sourceCordinate
            VC.destination = destinationCordinate
            self.present(VC, animated: true)
        }else{
            print("BOTH_CORDINATES_NOT_PRESENT")
        }
        
        
    }
    
    @objc private func didTapAsal() {
        let asalEntry = Tuju.AsalEntryViewController()
        asalEntry.completion = { [weak self] text in
            DispatchQueue.main.async {
                self?.sourceTextfield.text = text //Departure
            }
        }
        let vc = UINavigationController(rootViewController: asalEntry)
        present(vc, animated: true)
    }
    
    @objc private func didTapTujuan() {
        let tujuanEntry = Tuju.TujuanEntryViewController()
        tujuanEntry.completion = { [weak self] text in
            DispatchQueue.main.async {
                self?.destinationTextfield.text = text //Destination
            }
        }
        let vc = UINavigationController(rootViewController: tujuanEntry)
        present(vc, animated: true)
    }
    
    func AsalEntryViewController(_ vc: AsalEntryViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
//        guard let coordinates = coordinates else {
//            return
//        }
//
//        panel.move(to: .half, animated: true)
//
//        print("PANEL: \(coordinates.latitude), \(coordinates.longitude)")
//
//      let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 16.0)
//        mapView.animate(toLocation: coordinates)
//        mapView.camera = camera
//        mapView.animate(to: camera)
        
    }
    
//    func TujuanEntryViewController(_ vc: TujuanEntryViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
//
//        guard let coordinates = coordinates else {
//            return
//        }
//
//        // Hide panel
////        panel.move(to: .tip, animated: true)
//
//        // Coordinates
//        let pondokRanji: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
//
//        // Set Initial Camera Position
//        let pondokRanjiCam = GMSCameraUpdate.setTarget(
//            pondokRanji
//        )
//
//        let mapView = GMSMapView(frame: self.view.bounds)
//
//        mapView.animate(with: pondokRanjiCam)
//
//    }

}
