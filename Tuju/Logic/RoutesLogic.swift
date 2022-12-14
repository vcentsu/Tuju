//
//  RoutesLogic.swift
//  Tuju
//
//  Created by Eldwin Anthony on 24/10/22.
//

import Foundation
import UIKit

var hijauData = Hijau
var birukananData = BiruKanan
var birukiriData = BiruKiri
var merahatasData = MerahAtas
var merahbawahData = MerahBawah

var Departure = "Departure"
var Destination = "Destination"

var TransitStation = [String]()

var RoutesData = Routes
var numberOfTransit = 0

func RoutesLogic(){
    
    
    RoutesData.removeAll()
    TransitStation.removeAll()
    numberOfTransit = 0
    
    
    //Jalur Hijau (1 arah bolak balik)
    if (hijauData.contains(where: {$0.namaStasiun == Departure}) && hijauData.contains(where: {$0.namaStasiun == Destination})){

        let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        print(checkArr!)
        
        let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        
        print(checkDes!)
        
        if (checkArr! < checkDes!){
            let route = hijauData[checkArr!...checkDes!]
            print(route.count)
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
        }
        else{
            hijauData.reverse()
            let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
            let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
            let route = hijauData[checkArr!...checkDes!]
            print(route)
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
            hijauData.reverse()
        }
    }
    
    //Jalur Biru Kanan (1 arah bolak balik)
    else if (birukananData.contains(where: {$0.namaStasiun == Departure}) && birukananData.contains(where: {$0.namaStasiun == Destination})){
        
        let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        print(checkArr!)
        
        let checkDes = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        
        print(checkDes!)
        
        if (checkArr! < checkDes!){
            let route = birukananData[checkArr!...checkDes!]
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
        }
        else{
            birukananData.reverse()
            let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
            let checkDes = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
            let route = birukananData[checkArr!...checkDes!]
            
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
            birukananData.reverse()
        }
    }
    
   
    //Jalur Biru Kiri (1 arah bolak balik)
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure}) && birukiriData.contains(where: {$0.namaStasiun == Destination})){
        
        let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        print(checkArr!)
        
        let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        
        print(checkDes!)
        
        if (checkArr! < checkDes!){
            let route = birukiriData[checkArr!...checkDes!]
            print(RoutesData)
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
        }
        else{
            birukiriData.reverse()
            let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
            let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
            let route = birukiriData[checkArr!...checkDes!]
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
            birukiriData.reverse()
        }
    }
    
    //Jalur Merah Atas(1 arah bolak balik)
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure}) && merahatasData.contains(where: {$0.namaStasiun == Destination})){
        
        let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        print(checkArr!)
        
        let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        
        print(checkDes!)
        
        if (checkArr! < checkDes!){
            let route = merahatasData[checkArr!...checkDes!]
            print(RoutesData)
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
        }
        else{
            merahatasData.reverse()
            let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
            let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
            let route = merahatasData[checkArr!...checkDes!]
            
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
            merahatasData.reverse()
        }
    }
    
    //Jalur Merah Bawah (1 arah bolak balik)
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure}) && merahbawahData.contains(where: {$0.namaStasiun == Destination})){
        
        let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        print(checkArr!)
        
        let checkDes = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        
        print(checkDes!)
        
        if (checkArr! < checkDes!){
            let route = merahbawahData[checkArr!...checkDes!]
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
        }
        else{
            merahbawahData.reverse()
            let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
            let checkDes = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
            let route = merahbawahData[checkArr!...checkDes!]
            
            for i in checkArr!...checkDes! {
                RoutesData.append(Station(namaStasiun: route[i].namaStasiun, latitude: route[i].latitude, longitude: route[i].longitude))
            }
            
            merahbawahData.reverse()
        }
    }
    
    
    //Jalur Biru Kiri ke Biru Kanan
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure}) && birukananData.contains(where: {$0.namaStasiun == Destination})){

        //cek index array
        let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define route
        let route1 = birukiriData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = birukananData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
    }
    
    
    //Jalur Biru Kiri ke merah atas
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure}) && merahatasData.contains(where: {$0.namaStasiun == Destination})){

        //cek index array
        let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(birukiriData[2].namaStasiun!)
        
        //define route
        let route1 = birukiriData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = merahatasData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
    }
    
    
    //Jalur Biru Kiri ke merah bawah
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure}) && merahbawahData.contains(where: {$0.namaStasiun == Destination})){

        //cek index array
        let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(birukiriData[2].namaStasiun!)
        
        //define route
        let route1 = birukiriData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = merahbawahData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
    }
    
    //Jalur Biru Kanan ke Biru Kiri
    else if (birukananData.contains(where: {$0.namaStasiun == Departure}) && birukiriData.contains(where: {$0.namaStasiun == Destination})){

        birukananData.reverse()
        birukiriData.reverse()
        
        //cek index array
        let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define route
        let route1 = birukananData[checkArr!...1]
        for i in checkArr!...1 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        
        birukananData.reverse()
        birukiriData.reverse()
    }
    
    //Jalur merah atas ke Biru Kiri
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure}) && birukiriData.contains(where: {$0.namaStasiun == Destination})){

        merahatasData.reverse()
        birukiriData.reverse()
        
        //cek index array
        let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(merahatasData[6].namaStasiun!)
        
        //define route
        let route1 = merahatasData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        merahatasData.reverse()
        birukiriData.reverse()
    }
    
    //merah bawah ke biru kiri
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure}) && birukiriData.contains(where: {$0.namaStasiun == Destination})){


        merahbawahData.reverse()
        birukiriData.reverse()
        
        //cek index array
        let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(merahbawahData[6].namaStasiun!)
        
        //define route
        let route1 = merahbawahData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        merahbawahData.reverse()
        birukiriData.reverse()
    }
    
    //Jalur merah atas ke merah bawah
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure}) && merahbawahData.contains(where: {$0.namaStasiun == Destination})){
        
        merahatasData.reverse()
        
        //cek index array
        let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define route
        let route1 = merahatasData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = merahbawahData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        print(RoutesData)
        
        merahatasData.reverse()
    }
    
    //Jalur merah bawah ke merah atas
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure}) && merahatasData.contains(where: {$0.namaStasiun == Destination})){

        merahbawahData.reverse()
        
        //cek index array
        let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define route
        let route1 = merahbawahData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = merahatasData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        merahbawahData.reverse()
    }
    
    //Jalur merah atas ke biru kanan
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure}) && birukananData.contains(where: {$0.namaStasiun == Destination})){

        merahatasData.reverse()
        
        //cek index array
        let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(merahatasData[6].namaStasiun!)
        
        //define route
        let route1 = merahatasData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukananData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        merahatasData.reverse()
    }
    
    //Jalur biru kanan ke merah atas
    else if (birukananData.contains(where: {$0.namaStasiun == Departure}) && merahatasData.contains(where: {$0.namaStasiun == Destination})){

        birukananData.reverse()
        
        //cek index array
        let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(birukananData[2].namaStasiun!)
        
        //define route
        let route1 = birukananData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = merahatasData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        birukananData.reverse()
    }
    
    //Jalur biru kanan ke merah bawah
    else if (birukananData.contains(where: {$0.namaStasiun == Departure}) && merahbawahData.contains(where: {$0.namaStasiun == Destination})){


        birukananData.reverse()
        
        //cek index array
        let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(birukananData[2].namaStasiun!)
        
        //define route
        let route1 = BiruKanan[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = merahbawahData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        birukananData.reverse()
    }
    
    
    //Jalur merah bawah ke biru kanan
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure}) && birukananData.contains(where: {$0.namaStasiun == Destination})){

        merahbawahData.reverse()
        
        //cek index array
        let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 1
        
        //Transit Station
        TransitStation.append(merahbawahData[6].namaStasiun!)
        
        //define route
        let route1 = merahbawahData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = BiruKanan[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }

        merahbawahData.reverse()
    }
    
    //Jalur Hijau transit ke Biru Kiri
    else if (hijauData.contains(where: {$0.namaStasiun == Departure}) && birukiriData.contains(where: {$0.namaStasiun == Destination})){
        
        //cek index array
        let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        if(checkArr! < 3){
            numberOfTransit = 1
            //Transit Station
            TransitStation.append(hijauData[3].namaStasiun!)
        }
    
        //define route
        let route1 = hijauData[checkArr!...3]
        for i in checkArr!...3 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = birukiriData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
    }
    
    //Jalur Biru Kiri ke Hijau transit
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure}) && hijauData.contains(where: {$0.namaStasiun == Destination})){
        
        hijauData.reverse()
        birukiriData.reverse()
        
        //cek index array
        let checkArr = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        if(checkDes! > 0){
            numberOfTransit = 1
            //Transit Station
            TransitStation.append(hijauData[0].namaStasiun!)
        }
        
        //define route
        let route1 = birukiriData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = hijauData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        hijauData.reverse()
        birukiriData.reverse()
        
    }
    
    //Hijau - Biru Kiri - Merah Atas
    else if (hijauData.contains(where: {$0.namaStasiun == Departure}) && merahatasData.contains(where: {$0.namaStasiun == Destination})){

        //cek index Array
        let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 2
        
        //Transit Station
        TransitStation.append(hijauData[3].namaStasiun!)
        TransitStation.append(birukiriData[2].namaStasiun!)
        
        //define route
        let route1 = hijauData[checkArr!...3]
        for i in checkArr!...3 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = birukiriData[0...1]
        for i in 0...1 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = merahatasData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }
        
    }
    
    //Merah Atas - Biru Kiri - Hijau
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure}) && hijauData.contains(where: {$0.namaStasiun == Destination})){
        
        hijauData.reverse()
        birukiriData.reverse()
        merahatasData.reverse()
        
        //cek index array
        let checkArr = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        
        //define number of transit
        //Transit Station
        if(checkDes! > 0){
            TransitStation.append(hijauData[0].namaStasiun!)
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 2
        }
        else{
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 1
        }
        
        //define route
        let route1 = merahatasData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[1...2]
        for i in 1...2 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = hijauData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }

        hijauData.reverse()
        birukiriData.reverse()
        merahatasData.reverse()
        
    }
    
    //Hijau - Biru Kiri - Biru Kanan
    else if (hijauData.contains(where: {$0.namaStasiun == Departure}) && birukananData.contains(where: {$0.namaStasiun == Destination})){

        //cek index Array
        let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes =  birukananData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 2
        
        //Transit Station
        TransitStation.append(hijauData[3].namaStasiun!)
        TransitStation.append(birukiriData[2].namaStasiun!)
        
        //define route
        let route1 = hijauData[checkArr!...3]
        for i in checkArr!...3 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = birukiriData[0...2]
        for i in 0...2 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = birukananData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }
        

    }
    
    //Biru Kanan - Biru Kiri - Hijau
    else if (birukananData.contains(where: {$0.namaStasiun == Departure}) && hijauData.contains(where: {$0.namaStasiun == Destination})){
        
        hijauData.reverse()
        birukiriData.reverse()
        birukananData.reverse()
        
        //cek index array
        let checkArr = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        
        //define number of transit
        //Transit Station
        if(checkDes! > 0){
            TransitStation.append(hijauData[0].namaStasiun!)
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 2
        }
        else{
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 1
        }
        
        //define route
        let route1 = birukananData[checkArr!...2]
        for i in checkArr!...2 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[1...2]
        for i in 1...2 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = hijauData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }

        hijauData.reverse()
        birukiriData.reverse()
        birukananData.reverse()
        
    }
    
    //Hijau - Biru Kiri - Merah Bawah
    else if (hijauData.contains(where: {$0.namaStasiun == Departure}) && merahbawahData.contains(where: {$0.namaStasiun == Destination})){

        //cek index Array
        let checkArr = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes =  merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        //define number of transit
        numberOfTransit = 2
        
        //Transit Station
        TransitStation.append(hijauData[3].namaStasiun!)
        TransitStation.append(birukiriData[2].namaStasiun!)
        
        //define route
        let route1 = hijauData[checkArr!...3]
        for i in checkArr!...3 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }
        
        let route2 = birukiriData[0...2]
        for i in 0...2 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = merahbawahData[1...checkDes!]
        for i in 1...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }
        

    }
    
    //Merah Bawah - Biru Kiri - Hijau
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure}) && hijauData.contains(where: {$0.namaStasiun == Destination})){
        
        merahbawahData.reverse()
        birukiriData.reverse()
        hijauData.reverse()
        
        //cek index array
        let checkArr = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        print(checkArr!)
        
        //cek index array
        let checkDes = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Destination)"})
        print(checkDes!)
        
        
        //define number of transit
        //Transit Station
        if(checkDes! > 0){
            TransitStation.append(hijauData[0].namaStasiun!)
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 2
        }
        else{
            TransitStation.append(birukiriData[0].namaStasiun!)
            numberOfTransit = 1
        }
        
        //define route
        let route1 = merahbawahData[checkArr!...6]
        for i in checkArr!...6 {
            RoutesData.append(Station(namaStasiun: route1[i].namaStasiun, latitude: route1[i].latitude, longitude: route1[i].longitude))
        }

        let route2 = birukiriData[1...2]
        for i in 1...2 {
            RoutesData.append(Station(namaStasiun: route2[i].namaStasiun, latitude: route2[i].latitude, longitude: route2[i].longitude))
        }
        
        let route3 = hijauData[0...checkDes!]
        for i in 0...checkDes! {
            RoutesData.append(Station(namaStasiun: route3[i].namaStasiun, latitude: route3[i].latitude, longitude: route3[i].longitude))
        }

        hijauData.reverse()
        birukiriData.reverse()
        merahbawahData.reverse()
        
    }
}
