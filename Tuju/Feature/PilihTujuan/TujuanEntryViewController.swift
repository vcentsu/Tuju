//
//  TujuanEntryViewController.swift
//  TujuApp
//
//  Created by Ulul I. on 27/10/22.
//

import UIKit
import GoogleMaps

class TujuanEntryViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate {
    
    public var completion: ((Station?) -> Void)?
    
    var stations = [Station]()
    var originalStationsList = [Station]()
    
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
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
        
        tableView.backgroundColor = .secondarySystemBackground
        
        tujuanField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tujuanField.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 50)
        let tableY: CGFloat = tujuanField.frame.origin.y+tujuanField.frame.size.height+5
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-tableY)
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
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "station")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "station")
        }
        cell?.textLabel?.text = stations[indexPath.row].namaStasiun
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tujuanField.text = stations[indexPath.row].namaStasiun
        completion?(stations[indexPath.row])
        
        dismiss(animated: true, completion: nil)
        
    }
}
