//
//  FavAndRecentLogic.swift
//  Tuju
//
//  Created by Eldwin Anthony on 26/10/22.
//

import Foundation
import UIKit

var favoriteData = Favorite
var recentData = Recent

func FavAndRecentLogic(){
    //hijau
    if (hijauData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = hijauData[checkArrFavorite!].namaStasiun
        let tempLatitude = hijauData[checkArrFavorite!].latitude
        let templongitude = hijauData[checkArrFavorite!].longitude
        hijauData[checkArrFavorite!].isFavorite! += 1
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateFav = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicateFav!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            let tempisFavorite = hijauData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        // kalo uda ada di recent data maka +isfavoritenya aja 1
        if recentData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateRec = recentData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            recentData[checkDuplicateRec!].isFavorite! += 1
        }
        // kalo ga maka dia append ke recentdata dari temp
        else{
            let tempisFavorite = hijauData[checkArrFavorite!].isFavorite
            recentData.append(RecentContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
    }
    
    //biru kiri
    else if (birukiriData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = birukiriData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = birukiriData[checkArrFavorite!].namaStasiun
        let tempLatitude = birukiriData[checkArrFavorite!].latitude
        let templongitude = birukiriData[checkArrFavorite!].longitude
        birukiriData[checkArrFavorite!].isFavorite! += 1
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateFav = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicateFav!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            let tempisFavorite = birukiriData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        // kalo uda ada di recent data maka +isfavoritenya aja 1
        if recentData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateRec = recentData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            recentData[checkDuplicateRec!].isFavorite! += 1
        }
        // kalo ga maka dia append ke recentdata dari temp
        else{
            let tempisFavorite = birukiriData[checkArrFavorite!].isFavorite
            recentData.append(RecentContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
    }
    
    //merah atas
    else if (merahatasData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = merahatasData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = merahatasData[checkArrFavorite!].namaStasiun
        let tempLatitude = merahatasData[checkArrFavorite!].latitude
        let templongitude = merahatasData[checkArrFavorite!].longitude
        merahatasData[checkArrFavorite!].isFavorite! += 1
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateFav = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicateFav!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            let tempisFavorite = merahatasData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        // kalo uda ada di recent data maka +isfavoritenya aja 1
        if recentData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateRec = recentData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            recentData[checkDuplicateRec!].isFavorite! += 1
        }
        // kalo ga maka dia append ke recentdata dari temp
        else{
            let tempisFavorite = merahatasData[checkArrFavorite!].isFavorite
            recentData.append(RecentContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
    }
    
    //biru kanan
    else if (birukananData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = birukananData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = birukananData[checkArrFavorite!].namaStasiun
        let tempLatitude = birukananData[checkArrFavorite!].latitude
        let templongitude = birukananData[checkArrFavorite!].longitude
        birukananData[checkArrFavorite!].isFavorite! += 1
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateFav = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicateFav!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            let tempisFavorite = birukananData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        // kalo uda ada di recent data maka +isfavoritenya aja 1
        if recentData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateRec = recentData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            recentData[checkDuplicateRec!].isFavorite! += 1
        }
        // kalo ga maka dia append ke recentdata dari temp
        else{
            let tempisFavorite = birukananData[checkArrFavorite!].isFavorite
            recentData.append(RecentContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
    }
    
    //merah bawah
    else if (merahbawahData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = merahbawahData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = merahbawahData[checkArrFavorite!].namaStasiun
        let tempLatitude = merahbawahData[checkArrFavorite!].latitude
        let templongitude = merahbawahData[checkArrFavorite!].longitude
        merahbawahData[checkArrFavorite!].isFavorite! += 1
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateFav = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicateFav!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            let tempisFavorite = merahbawahData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        // kalo uda ada di recent data maka +isfavoritenya aja 1
        if recentData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicateRec = recentData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            recentData[checkDuplicateRec!].isFavorite! += 1
        }
        // kalo ga maka dia append ke recentdata dari temp
        else{
            let tempisFavorite = merahbawahData[checkArrFavorite!].isFavorite
            recentData.append(RecentContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
    }
    print(favoriteData)
    print(recentData)

}
