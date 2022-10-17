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
    
    var Departure = "Departure"
    var Destination = "Destination"
    
    var TransitStation = [String]()
    
    var Routes = [String]()
    var numberOfTransit = 0
    
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
        
        //Reset all the array
        Routes.removeAll()
        TransitStation.removeAll()
        numberOfTransit = 0
        
        Departure = DepartureTF.text!
        Destination = DestinationTF.text!
        
        //Jalur Hijau (1 arah bolak balik)
        if (Hijau.contains(Departure) && Hijau.contains(Destination)){
            
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            
            print(checkArr!)
            
            let checkDes = Hijau.firstIndex(where:{ $0 == "\(Destination)"})
            
            print(checkDes!)
            
            if (checkArr! < checkDes!){
                let route = Hijau[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
            }
            else{
                Hijau.reverse()
                let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
                let checkDes = Hijau.firstIndex(where:{ $0 == "\(Destination)"})
                let route = Hijau[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                
                Hijau.reverse()
            }
        }
        
        //Jalur Biru Kanan (1 arah bolak balik)
        if (BiruKanan.contains(Departure) && BiruKanan.contains(Destination)){
            
            let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
            
            print(checkArr!)
            
            let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
            
            print(checkDes!)
            
            if (checkArr! < checkDes!){
                let route = BiruKanan[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
            }
            else{
                BiruKanan.reverse()
                let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
                let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
                let route = BiruKanan[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
                BiruKanan.reverse()
            }
        }
        
        //Jalur Biru Kiri (1 arah bolak balik)
        if(BiruKiri.contains(Departure) && BiruKiri.contains(Destination)){
            
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            
            print(checkArr!)
            
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            
            print(checkDes!)
            
            if (checkArr! < checkDes!){
                let route = BiruKiri[checkArr!...checkDes!]
                print(Routes)
                Routes.append(contentsOf: route)
            }
            else{
                BiruKiri.reverse()
                let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
                let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
                let route = BiruKiri[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
                
                BiruKiri.reverse()
            }
        }
        
        
        //Jalur Biru Kiri ke Biru Kanan
        if(BiruKiri.contains(Departure) && BiruKanan.contains(Destination)){

            //cek index array
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define route
            let route1 = BiruKiri[checkArr!...2]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKanan[0...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
        }
        
        //Jalur Biru Kanan ke Biru Kiri
        if(BiruKanan.contains(Departure) && BiruKiri.contains(Destination)){

            BiruKanan.reverse()
            BiruKiri.reverse()
            
            //cek index array
            let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define route
            let route1 = BiruKanan[checkArr!...1]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[0...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            BiruKanan.reverse()
            BiruKiri.reverse()
        }
        
        //Jalur Hijau transit ke Biru Kiri
        if(Hijau.contains(Departure) && BiruKiri.contains(Destination)){
            
            //cek index array
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(Hijau[3])
        
            //define route
            let route1 = Hijau[checkArr!...3]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKiri[0...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            //print label
            numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
            transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
        }
        
        //Jalur Biru Kiri ke Hijau transit
        if(BiruKiri.contains(Departure) && Hijau.contains(Destination)){
            
            Hijau.reverse()
            BiruKiri.reverse()
            
            //cek index array
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = Hijau.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            if(checkDes! > 0){
                numberOfTransit = 1
                //Transit Station
                TransitStation.append(Hijau[0])
            }
            
            //define route
            let route1 = BiruKiri[checkArr!...2]
            Routes.append(contentsOf: route1)
    
            let route2 = Hijau[0...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            //print label
            numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
            transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
            
            Hijau.reverse()
            BiruKiri.reverse()
            
        }
        
        //Hijau ke Merah Atas
        if(Hijau.contains(Departure) && MerahAtas.contains(Destination)){

            //cek index Array
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 2
            
            //Transit Station
            TransitStation.append(Hijau[3])
            TransitStation.append(BiruKiri[2])
            
            //define route
            let route1 = Hijau[checkArr!...3]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKiri[0...2]
            Routes.append(contentsOf: route2)
            
            let route3 = MerahAtas[0...checkDes!]
            Routes.append(contentsOf: route3)
            
            //print label
            numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
            transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
            
            print(Routes)
            
        }
        
        //Merah Atas ke Hijau
        if(MerahAtas.contains(Departure) && Hijau.contains(Destination)){
            
            Hijau.reverse()
            BiruKiri.reverse()
            MerahAtas.reverse()
            
            //cek index array
            let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = Hijau.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            
            //define number of transit
            //Transit Station
            if(checkDes! > 0){
                TransitStation.append(Hijau[0])
                TransitStation.append(BiruKiri[0])
                numberOfTransit = 2
            }
            else{
                TransitStation.append(BiruKiri[0])
                numberOfTransit = 1
            }
            
            //define route
            let route1 = MerahAtas[checkArr!...5]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[0...2]
            Routes.append(contentsOf: route2)
            
            let route3 = Hijau[0...checkDes!]
            Routes.append(contentsOf: route3)
            print(Routes)
            
            //print label
            numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
            transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
            
            Hijau.reverse()
            BiruKiri.reverse()
            MerahAtas.reverse()
            
        }
        
        self.tableView.reloadData()
    }
    
}

