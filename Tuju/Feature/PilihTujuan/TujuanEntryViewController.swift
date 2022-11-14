//
//  TujuanEntryViewController.swift
//  TujuApp
//
//  Created by Ulul I. on 27/10/22.
//

import UIKit
import GoogleMaps


protocol TujuanEntryViewControllerDelegate: AnyObject {
    func TujuanEntryViewController(_ vc: TujuanEntryViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}


class TujuanEntryViewController: UIViewController, UITextFieldDelegate, GMSMapViewDelegate {
    
    weak var delegate: TujuanEntryViewControllerDelegate?
    
    public var completion: ((Station?) -> Void)?
    
    var locations = [Location]()
    
    var stations = [Station]()
    var originalStationsList = [Station]()
    
    let tujuanTitle: UILabel = {
        let label = UILabel()
        label.text = "Tujuan"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let tujuanField: UITextField = {
        let field = UITextField()
        field.placeholder = "Tujuan: Pilih Stasiun Tujuan"
        field.layer.cornerRadius = 9
        field.backgroundColor = .clear
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.returnKeyType = .done
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        
        return field
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RecommendationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        view.addSubview(tujuanTitle)
        view.addSubview(tujuanField)
        view.addSubview(tableView)
        
        stations.append(pondokRanji)
        stations.append(kebayoran)
        stations.append(manggarai)
        stations.append(palmerah)
        stations.append(tanahAbang)
        stations.append(karet)
        stations.append(sudirman)
        stations.append(cikini)
        stations.append(gondangdia)
        stations.append(gambir)
        stations.append(juanda)
        stations.append(sawahBesar)
        stations.append(manggaBesar)
        stations.append(matraman)
        stations.append(jatinegara)
        stations.append(tebet)
        stations.append(cawang)
        stations.append(durenKalibata)
        stations.append(pasarMingguBaru)
        stations.append(pasarMinggu)
        stations.append(tanjungBaarat)
        
        for station in stations {
            originalStationsList.append(station)
        }

        tableView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tujuanField.delegate = self
        
        tableView.backgroundColor = .clear
        
        tujuanField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tujuanTitle.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.size.width-40, height: 0, enableInsets: false)
        tujuanField.anchor(top: tujuanTitle.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.size.width-40, height: 50, enableInsets: false)
        let tableY: CGFloat = tujuanField.frame.origin.y+tujuanField.frame.size.height+5
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-tableY)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tujuanField.resignFirstResponder()
        
        if let text = tujuanField.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                    
                }
            }
        }
        return true
    }
    
    //Search
    @objc func searchRecords(_ textField: UITextField){
        
        tableView.isHidden = false
        self.stations.removeAll()
        if textField.text?.count != 0 {
            
            for station in originalStationsList {
                if let stationToSearch = textField.text{
                    let range  = station.namaStasiun?.lowercased().range(of: stationToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.stations.append(station)
                    }
                }
                
            }
        } else if textField.text?.count == 0 {
            tableView.isHidden = true
        } else {
            
            for station in originalStationsList {
                stations.append(station)
            }
            
        }
        
        tableView.reloadData()
    }
    
}

extension TujuanEntryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell = tableView.dequeueReusableCell(withIdentifier: "station")
//
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "station")
//        }
//        cell?.textLabel?.text = stations[indexPath.row].namaStasiun
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecommendationTableViewCell

        cell.namaStasiun.text = stations[indexPath.row].namaStasiun
        cell.jarakStasiun.text = "12km"
        cell.contentView.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Notify  map controller to show pin at selected place
//        let coordinate = locations[indexPath.row].coordinates
//
//        delegate?.TujuanEntryViewController(self, didSelectLocationWith: coordinate)
//
//        print("YOUR COORDINATE: \(coordinate.latitude), \(coordinate.longitude)")
        
        tujuanField.text = stations[indexPath.row].namaStasiun
        completion?(stations[indexPath.row])
        
        dismiss(animated: true, completion: nil)
        
    }
}
