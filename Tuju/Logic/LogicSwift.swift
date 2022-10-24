//
//  LogicSwift.swift
//  Tuju
//
//  Created by Eldwin Anthony on 17/10/22.
//
import UIKit

class LogicSwift: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var numberOfTransitLbl: UILabel!
    @IBOutlet weak var transitStationLbl: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var DestinationTF: UITextField!
    @IBOutlet weak var DepartureTF: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        
        let nib = UINib(nibName: "TestTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TestTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as! TestTableViewCell
        cell.departurestationLbl.text = Routes[indexPath.row]
        
        if(indexPath.row < Routes.count - 1){
            cell.destinationstationLbl.text = Routes[indexPath.row + 1]
        }
        else{
            cell.destinationstationLbl.text = "Arrived"
        }
        
        //kalo dia uda arrive
        if(indexPath.row == Routes.count - 1){
            cell.transitLbl.isHidden = true
        }
        else if(indexPath.row == 0){
            cell.transitLbl.isHidden = true
        }
        //kalo belom arrive dan ada turun di TA atau Manggarai
        else if(Routes[indexPath.row] == "Tanah Abang" || Routes[indexPath.row] == "Manggarai"){
            cell.transitLbl.isHidden = false
            cell.transitLbl.text = "Transit"
        }
        else{
            cell.transitLbl.isHidden = true
        }
        
        return cell
        
    }
    

    @IBAction func BtnPressed(_ sender: Any) {
        
        Departure = DepartureTF.text!
        Destination = DestinationTF.text!
        
        RoutesLogic()
        
        //print label
        numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
        transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
        
        self.tableView.reloadData()
    }
    
}

