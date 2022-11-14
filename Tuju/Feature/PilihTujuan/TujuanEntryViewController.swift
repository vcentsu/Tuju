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
    
    private let searchTableView: UITableView = {
        let table = UITableView()
        table.register(RecommendationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private let recentfavTableView: UITableView = {
        let table = UITableView()
        table.register(RecommendationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    lazy var emptyImg: UIImageView = {
        let image = UIImage(systemName: "tram.fill")
        let imgView = UIImageView()
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = UIColor(red: 255/255, green: 118/255, blue: 12/255, alpha: 0.5)
        imgView.isHidden = true
        return imgView
    }()
    
    lazy var emptyLbl: UILabel = {
        let label = UILabel()
        label.text = "Upss, riwayat pencarian masih kosong!"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 124/255, green: 24/255, blue: 124/255, alpha: 0.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        view.addSubview(tujuanTitle)
        view.addSubview(tujuanField)
        
        tujuanField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        
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

        // Table
        view.addSubview(searchTableView)
        view.addSubview(recentfavTableView)
        searchTableView.isHidden = true
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .clear
        
        recentfavTableView.isHidden = false
        recentfavTableView.delegate = self
        recentfavTableView.dataSource = self
        recentfavTableView.backgroundColor = .clear
        
        if recentData.isEmpty {
            recentfavTableView.isHidden = true
            view.addSubview(emptyImg)
            view.addSubview(emptyLbl)
            emptyImg.anchor(top: recentfavTableView.topAnchor , left: recentfavTableView.leftAnchor, bottom: nil, right: recentfavTableView.rightAnchor, paddingTop: 90, paddingLeft: 80, paddingBottom: 0, paddingRight: 80, width: 70, height: 70, enableInsets: false)
            emptyLbl.anchor(top: emptyImg.bottomAnchor, left: recentfavTableView.leftAnchor, bottom: nil, right: recentfavTableView.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 270, height: 60, enableInsets: false)
            
            emptyImg.isHidden = false
            emptyLbl.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tujuanTitle.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.size.width-40, height: 0, enableInsets: false)
        tujuanField.anchor(top: tujuanTitle.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.size.width-40, height: 50, enableInsets: false)
        let tableY: CGFloat = tujuanField.frame.origin.y+tujuanField.frame.size.height+5
        searchTableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-tableY)
        recentfavTableView.frame = CGRect(x: 0,
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
                    self?.searchTableView.reloadData()
                    
                }
            }
        }
        return true
    }
    
    //Search
    @objc func searchRecords(_ textField: UITextField){
        
        searchTableView.isHidden = false
        recentfavTableView.isHidden = true
        emptyImg.isHidden = true
        emptyLbl.isHidden = true
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
            searchTableView.isHidden = true
            emptyImg.isHidden = false
            emptyLbl.isHidden = false
            if !recentData.isEmpty{
                recentfavTableView.isHidden = false
                emptyImg.isHidden = true
                emptyLbl.isHidden = true
            }
        } else {
            for station in originalStationsList {
                stations.append(station)
            }
        }
        searchTableView.reloadData()
    }
}

extension TujuanEntryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var i: Int = 1
        if tableView == recentfavTableView{
            i = 2
        }else if tableView == searchTableView{
            i = 1
        }
        return i
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        if tableView == recentfavTableView{
            switch section {
            case 0:
                sectionName = NSLocalizedString("Favorite", comment: "Favorite")
            case 1:
                sectionName = NSLocalizedString("Recent", comment: "Recent")
                // ...
            default:
                sectionName = "Recent"
            }
        } else if tableView == searchTableView{
            sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i: Int = 1
        if tableView == recentfavTableView{
            switch section {
            case 0:
                i = favoriteData.count
            case 1:
                i = recentData.count
            default:
                i = recentData.count
            }
        } else if tableView == searchTableView{
            i = stations.count
        }
        return i
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecommendationTableViewCell
        
        if tableView == recentfavTableView {
            cell.namaStasiun.text = recentData[indexPath.row].namaStasiun
            cell.jarakStasiun.text = "15km"
        } else if tableView == searchTableView {
            cell.namaStasiun.text = stations[indexPath.row].namaStasiun
            cell.jarakStasiun.text = "12km"
        }
        
        cell.contentView.backgroundColor = .white
        //        return cell
        
        //        var cell = tableView.dequeueReusableCell(withIdentifier: "station")
        //
        //        if cell == nil {
        //            cell = UITableViewCell(style: .default, reuseIdentifier: "station")
        //        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Notify  map controller to show pin at selected place
//        guard let lat = stations[indexPath.row].latitude  else { return "" }
//        guard let long = stations[indexPath.row].longitude else { return "" }
//        let coordonates = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
//        delegate?.AsalEntryViewController(self, didSelectLocationWith: coordonates)
//
//        print("YOUR COORDINATE ASAL: \(coordinate.latitude), \(coordinate.longitude)")
        if tableView == recentfavTableView {
            tujuanField.text = recentData[indexPath.row].namaStasiun
            completion?(recentData[indexPath.row])
        }else if tableView == searchTableView {
            tujuanField.text = stations[indexPath.row].namaStasiun
            completion?(stations[indexPath.row])
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
        
//        let PanelVC = self.storyboard?.instantiateViewController(withIdentifier: "PanelViewController") as! PanelViewController
//
//        PanelVC.asalField.text = stations[indexPath.row]
//
//           self.navigationController?.pushViewController(PanelVC, animated: true)
        
    }
}
