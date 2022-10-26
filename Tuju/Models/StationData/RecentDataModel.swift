//
//  RecentDataModel.swift
//  Tuju
//
//  Created by Eldwin Anthony on 26/10/22.
//

import Foundation
import UIKit

struct RecentContent{
    var namaStasiun: String?
    var latitude: Double?
    var longitude: Double?
    var isFavorite: Int?
}

//insert the dummy data
var Recent: [RecentContent] = [
    RecentContent(namaStasiun: "Karet", latitude: -6.200547009851408, longitude: 106.81575013745739, isFavorite: 3)
]
