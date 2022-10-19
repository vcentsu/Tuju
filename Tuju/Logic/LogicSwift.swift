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
        else if (BiruKanan.contains(Departure) && BiruKanan.contains(Destination)){
            
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
        else if(BiruKiri.contains(Departure) && BiruKiri.contains(Destination)){
            
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
        
        //Jalur Merah Atas(1 arah bolak balik)
        else if(MerahAtas.contains(Departure) && MerahAtas.contains(Destination)){
            
            let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
            
            print(checkArr!)
            
            let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
            
            print(checkDes!)
            
            if (checkArr! < checkDes!){
                let route = MerahAtas[checkArr!...checkDes!]
                print(Routes)
                Routes.append(contentsOf: route)
            }
            else{
                MerahAtas.reverse()
                let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
                let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
                let route = MerahAtas[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
                
                MerahAtas.reverse()
            }
        }
        
        //Jalur Merah Bawah (1 arah bolak balik)
        else if(MerahBawah.contains(Departure) && MerahBawah.contains(Destination)){
            
            let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
            
            print(checkArr!)
            
            let checkDes = MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
            
            print(checkDes!)
            
            if (checkArr! < checkDes!){
                let route = MerahBawah[checkArr!...checkDes!]
                print(Routes)
                Routes.append(contentsOf: route)
            }
            else{
                MerahBawah.reverse()
                let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
                let checkDes = MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
                let route = MerahBawah[checkArr!...checkDes!]
                Routes.append(contentsOf: route)
                print(Routes)
                
                MerahBawah.reverse()
            }
        }
        
        
        //Jalur Biru Kiri ke Biru Kanan
        else if(BiruKiri.contains(Departure) && BiruKanan.contains(Destination)){

            //cek index array
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define route
            let route1 = BiruKiri[checkArr!...2]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKanan[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
        }
        
        
        //Jalur Biru Kiri ke merah atas
        else if(BiruKiri.contains(Departure) && MerahAtas.contains(Destination)){

            //cek index array
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(BiruKiri[2])
            
            //define route
            let route1 = BiruKiri[checkArr!...2]
            Routes.append(contentsOf: route1)
            
            let route2 = MerahAtas[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
        }
        
        //Jalur Biru Kiri ke merah bawah
        else if(BiruKiri.contains(Departure) && MerahBawah.contains(Destination)){

            //cek index array
            let checkArr = BiruKiri.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(BiruKiri[2])
            
            //define route
            let route1 = BiruKiri[checkArr!...2]
            Routes.append(contentsOf: route1)
            
            let route2 = MerahBawah[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
        }
        
        //Jalur Biru Kanan ke Biru Kiri
        else if(BiruKanan.contains(Departure) && BiruKiri.contains(Destination)){

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
        
        //Jalur merah atas ke Biru Kiri
        else if(MerahAtas.contains(Departure) && BiruKiri.contains(Destination)){

            MerahAtas.reverse()
            BiruKiri.reverse()
            
            //cek index array
            let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(MerahAtas[6])
            
            //define route
            let route1 = MerahAtas[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahAtas.reverse()
            BiruKiri.reverse()
        }
        
        //merah bawah ke biru kiri
        else if(MerahBawah.contains(Departure) && BiruKiri.contains(Destination)){

            MerahBawah.reverse()
            BiruKiri.reverse()
            
            //cek index array
            let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(MerahBawah[6])
            
            //define route
            let route1 = MerahBawah[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahBawah.reverse()
            BiruKiri.reverse()
        }
        
        //Jalur merah atas ke merah bawah
        else if(MerahAtas.contains(Departure) && MerahBawah.contains(Destination)){

            MerahAtas.reverse()
            
            //cek index array
            let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define route
            let route1 = MerahAtas[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = MerahBawah[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahAtas.reverse()
        }
        
        //Jalur merah bawah ke merah atas
        else if(MerahBawah.contains(Departure) && MerahAtas.contains(Destination)){

            MerahBawah.reverse()
            
            //cek index array
            let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define route
            let route1 = MerahBawah[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = MerahAtas[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahBawah.reverse()
        }
        
        //Jalur merah atas ke biru kanan
        else if(MerahAtas.contains(Departure) && BiruKanan.contains(Destination)){

            MerahAtas.reverse()
            
            //cek index array
            let checkArr = MerahAtas.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(MerahAtas[6])
            
            //define route
            let route1 = MerahAtas[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKanan[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahAtas.reverse()
        }
        
        //Jalur biru kanan ke merah atas
        else if(BiruKanan.contains(Departure) && MerahAtas.contains(Destination)){

            BiruKanan.reverse()
            
            //cek index array
            let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahAtas.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(BiruKanan[2])
            
            //define route
            let route1 = BiruKanan[checkArr!...2]
            Routes.append(contentsOf: route1)
    
            let route2 = MerahAtas[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            BiruKanan.reverse()
        }
        
        //Jalur biru kanan ke merah bawah
        else if(BiruKanan.contains(Departure) && MerahBawah.contains(Destination)){

            BiruKanan.reverse()
            
            //cek index array
            let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(BiruKanan[2])
            
            //define route
            let route1 = BiruKanan[checkArr!...2]
            Routes.append(contentsOf: route1)
    
            let route2 = MerahBawah[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            BiruKanan.reverse()
        }
        
        
        //Jalur merah bawah ke biru kanan
        else if(MerahBawah.contains(Departure) && BiruKanan.contains(Destination)){

            MerahBawah.reverse()
            
            //cek index array
            let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 1
            
            //Transit Station
            TransitStation.append(MerahBawah[6])
            
            //define route
            let route1 = MerahBawah[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKanan[1...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            MerahBawah.reverse()
        }
        
        //Jalur Hijau transit ke Biru Kiri
        else if(Hijau.contains(Departure) && BiruKiri.contains(Destination)){
            
            //cek index array
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes = BiruKiri.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            if(checkArr! < 3){
                numberOfTransit = 1
                //Transit Station
                TransitStation.append(Hijau[3])
            }
        
            //define route
            let route1 = Hijau[checkArr!...3]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKiri[0...checkDes!]
            Routes.append(contentsOf: route2)
            
            print(Routes)
            
            
        }
        
        //Jalur Biru Kiri ke Hijau transit
        else if(BiruKiri.contains(Departure) && Hijau.contains(Destination)){
            
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
            
            Hijau.reverse()
            BiruKiri.reverse()
            
        }
        
        //Hijau - Biru Kiri - Merah Atas
        else if(Hijau.contains(Departure) && MerahAtas.contains(Destination)){

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
            
            let route2 = BiruKiri[0...1]
            Routes.append(contentsOf: route2)
            
            let route3 = MerahAtas[0...checkDes!]
            Routes.append(contentsOf: route3)
            
            print(Routes)
            
        }
        
        //Merah Atas - Biru Kiri - Hijau
        else if(MerahAtas.contains(Departure) && Hijau.contains(Destination)){
            
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
            let route1 = MerahAtas[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[1...2]
            Routes.append(contentsOf: route2)
            
            let route3 = Hijau[0...checkDes!]
            Routes.append(contentsOf: route3)
            print(Routes)
            
            Hijau.reverse()
            BiruKiri.reverse()
            MerahAtas.reverse()
            
        }
        
        //Hijau - Biru Kiri - Biru Kanan
        else if(Hijau.contains(Departure) && BiruKanan.contains(Destination)){

            //cek index Array
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes =  BiruKanan.firstIndex(where:{ $0 == "\(Destination)"})
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
            
            let route3 = BiruKanan[1...checkDes!]
            Routes.append(contentsOf: route3)
            
            print(Routes)
            
        }
        
        //Biru Kanan - Biru Kiri - Hijau
        else if(BiruKanan.contains(Departure) && Hijau.contains(Destination)){
            
            Hijau.reverse()
            BiruKiri.reverse()
            BiruKanan.reverse()
            
            //cek index array
            let checkArr = BiruKanan.firstIndex(where:{ $0 == "\(Departure)"})
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
            let route1 = BiruKanan[checkArr!...2]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[1...2]
            Routes.append(contentsOf: route2)
            
            let route3 = Hijau[0...checkDes!]
            Routes.append(contentsOf: route3)
            print(Routes)
            
            Hijau.reverse()
            BiruKiri.reverse()
            BiruKanan.reverse()
            
        }
        
        //Hijau - Biru Kiri - Merah Bawah
        else if(Hijau.contains(Departure) && MerahBawah.contains(Destination)){

            //cek index Array
            let checkArr = Hijau.firstIndex(where:{ $0 == "\(Departure)"})
            print(checkArr!)
            
            //cek index array
            let checkDes =  MerahBawah.firstIndex(where:{ $0 == "\(Destination)"})
            print(checkDes!)
            
            //define number of transit
            numberOfTransit = 2
            
            //Transit Station
            TransitStation.append(Hijau[3])
            TransitStation.append(BiruKiri[2])
            
            //define route
            let route1 = Hijau[checkArr!...2]
            Routes.append(contentsOf: route1)
            
            let route2 = BiruKiri[0...2]
            Routes.append(contentsOf: route2)
            
            let route3 = MerahBawah[1...checkDes!]
            Routes.append(contentsOf: route3)
            
            print(Routes)
            
        }
        
        //Merah Bawah - Biru Kiri - Hijau
        else if(MerahBawah.contains(Departure) && Hijau.contains(Destination)){
            
            Hijau.reverse()
            BiruKiri.reverse()
            MerahBawah.reverse()
            
            //cek index array
            let checkArr = MerahBawah.firstIndex(where:{ $0 == "\(Departure)"})
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
            let route1 = MerahBawah[checkArr!...6]
            Routes.append(contentsOf: route1)
    
            let route2 = BiruKiri[1...2]
            Routes.append(contentsOf: route2)
            
            let route3 = Hijau[0...checkDes!]
            Routes.append(contentsOf: route3)
            print(Routes)
            
            Hijau.reverse()
            BiruKiri.reverse()
            MerahBawah.reverse()
            
        }
        
        //print label
        numberOfTransitLbl.text = ("Anda Harus Transit \(numberOfTransit) Kali")
        transitStationLbl.text = ("Transit di Stasiun \(TransitStation)")
        
        self.tableView.reloadData()
    }
    
}

