//
//  FavAndRecentLogic.swift
//  Tuju
//
//  Created by Eldwin Anthony on 26/10/22.
//

import Foundation
import UIKit

var favoriteData = Favorite

func FavAndRecentLogic(){
    if (hijauData.contains(where: {$0.namaStasiun == Departure})){
        //cek index dari yg di departure sesuaiin sama yg di struct
        let checkArrFavorite = hijauData.firstIndex(where:{ $0.namaStasiun == "\(Departure)"})
        
        //simpen variabel ke temp
        let tempNamaStasiun = hijauData[checkArrFavorite!].namaStasiun
        let tempLatitude = hijauData[checkArrFavorite!].latitude
        let templongitude = hijauData[checkArrFavorite!].longitude
        
        
        //kalo uda ada di favorite data maka +isfavoritenya aja 1
        if favoriteData.contains(where: {$0.namaStasiun == tempNamaStasiun}){
            let checkDuplicate = favoriteData.firstIndex(where: {$0.namaStasiun == tempNamaStasiun})
            favoriteData[checkDuplicate!].isFavorite! += 1
            hijauData[checkArrFavorite!].isFavorite! += 1
        }
        //kalo ga maka dia append dari yg temp
        else{
            hijauData[checkArrFavorite!].isFavorite! += 1
            let tempisFavorite = hijauData[checkArrFavorite!].isFavorite
            favoriteData.append(FavoriteContent(namaStasiun: tempNamaStasiun, latitude: tempLatitude, longitude: templongitude, isFavorite: tempisFavorite))
        }
        

        print(favoriteData)
        print(hijauData)
    }

}
