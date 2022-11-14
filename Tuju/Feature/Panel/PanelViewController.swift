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
import UserNotifications



let backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 246/255, alpha: 1)

class PanelViewController: UIViewController, UITextFieldDelegate{


    let panel = FloatingPanelController()
    
    weak var delegate: PanelViewControllerDelegate?
    
    var locations = [Location]()
    var tempdep: String = ""
    var tempdes: String = ""
    
    let perjalananView = Tuju.PerjalananViewController()
    
//    let mapView = GMSMapView(frame: .zero)
    
    lazy var asalField: UITextField = {
        let field = UITextField()
        field.placeholder = "Asal: Pilih Stasiun Asal"
        field.layer.cornerRadius = 9
        field.backgroundColor = .clear
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        return field
    }()
    
    lazy var tujuanField: UITextField = {
        let field = UITextField()
        field.placeholder = "Tujuan: Pilih Stasiun Tujuan"
        field.layer.cornerRadius = 9
        field.backgroundColor = .clear
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        return field
    }()
    
    
    lazy var startBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Mulai Perjalanan!", for: .normal)
        button.backgroundColor = .lightGray
        
        button.addTarget(self, action: #selector(didTapMulai), for: .touchUpInside)
        button.isEnabled = false
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
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor(red: 124/255, green: 24/255, blue: 124/255, alpha: 1)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        //Asal
        view.addSubview(asalField)
        asalField.addTarget(self, action: #selector(didTapAsal), for: .touchUpInside)
        asalField.delegate = self
    
        //Tujuan
        view.addSubview(tujuanField)
        tujuanField.addTarget(self, action: #selector(didTapTujuan), for: .touchUpInside)
        tujuanField.delegate = self
        
        view.addSubview(label)
        view.addSubview(startBtn)
        
        asalField.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 50)
        tujuanField.frame = CGRect(x: 20, y: 40+asalField.frame.size.height, width: view.frame.size.width-40, height: 50)
        
        label.sizeToFit()
        label.frame = CGRect(x: 25, y: 120+tujuanField.frame.size.height, width: label.frame.size.width, height: label.frame.size.height)
        
        startBtn.frame = CGRect(x: 20, y: 180+label.frame.size.height, width: view.frame.size.width-40, height: 50)
        startBtn.applyGradient(withColours: [UIColor(red: 248/255, green: 221/255, blue: 204/255, alpha: 1),UIColor(red: 252/255, green: 238/255, blue: 209/255, alpha: 1)], gradientOrientation: .topRightBottomLeft)

//        let asalVC = Tuju.AsalEntryViewController()
//        asalVC.delegate = self
        
//        updateView()
        
    }
    
    func updateView(){
        if asalField.text == "" || tujuanField.text == "" {
            //startBtn.backgroundColor = .systemGreen
            startBtn.isEnabled = false
        } else {
            startBtn.isEnabled = true
            DispatchQueue.main.async {
                self.startBtn.applyGradient(withColours: [UIColor(red: 222/255, green: 0, blue: 0, alpha: 1),UIColor(red: 255/255, green: 119/255, blue: 10/255, alpha: 1)], gradientOrientation: .topRightBottomLeft)
                self.startBtn.layer.cornerRadius = 19
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        mapView.frame = view.bounds
        
        
    }
    
    @objc private func didTapMulai() {
        // Draw the direction
        panel.move(to: .tip, animated: true)
        Departure = tempdep
        Destination = tempdes
        RoutesLogic()
        FavAndRecentLogic()
        nextStationGeofence()
        addDestinationGeofence()
        print(recentData)
        print(favoriteData)
        print(TransitStation)
        print(RoutesData)
        print(numberOfTransit)
        

        
//        perjalananView.delegate = self
        self.navigationController?.pushViewController(perjalananView, animated: true)
        

    }
    
    @objc private func didTapAsal() {
        let asalEntry = Tuju.AsalEntryViewController()
//        asalEntry.delegate = self
        
//        let vc = UINavigationController(rootViewController: asalEntry)
        present(asalEntry, animated: true)
        
        asalEntry.completion = { [weak self] station in
            guard let station = station else {return}

            let coordinates = CLLocationCoordinate2D(latitude: station.latitude ?? 0.0, longitude: station.longitude ?? 0.0)
            self!.delegate?.PanelViewController(didSelectLocationWith: coordinates)
            
//            DispatchQueue.main.async {
//                self?.asalField.text = "Asal: \(station.namaStasiun ?? "Pilih stasiun asal")" //Departure
//            }
            self?.asalField.text = "Asal: \(station.namaStasiun ?? "Pilih stasiun asal")" //Departure
            if let dep = station.namaStasiun {
                self?.tempdep = dep
            }
            self?.updateView()
            
        }
    }
    
    @objc private func didTapTujuan() {
        let tujuanEntry = Tuju.TujuanEntryViewController()
//        tujuanEntry.delegate = self
        
//        let vc = UINavigationController(rootViewController: tujuanEntry)
        present(tujuanEntry, animated: true)
        
        tujuanEntry.completion = { [weak self] station in
            guard let station = station else {return}
            
//            DispatchQueue.main.async {
//                self?.tujuanField.text = "Tujuan: \(station.namaStasiun ?? "Pilih stasiun tujuan")" //Destination
//            }
            self?.tujuanField.text = "Tujuan: \(station.namaStasiun ?? "Pilih stasiun tujuan")" //Destination
            if let des = station.namaStasiun {
                self?.tempdes = des
            }
            self?.updateView()
        }
    }
    
//    func AsalEntryViewController(_ vc: AsalEntryViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
//
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
//
//    }
//
//    func TujuanEntryViewController(_ vc: TujuanEntryViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
//
//        print(#function)
//
//    }
    
    
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

extension PanelViewController {

    func refreshCollectionView() {
        //perintahkan PerjalananView untuk refresh CollectionView
        print(#function)
        perjalananView.myCollectionView.reloadData()
    }
    
}
