//
//  StationDataDetails.swift
//  Tuju
//
//  Created by Eldwin Anthony on 21/10/22.
//

import Foundation
import UIKit

// New coordinates based on CoreLocation specific for stations
let pondokRanji = Station(namaStasiun: "Pondok Ranji", latitude: -6.2763674, longitude: 106.744919, isFavorite: 0)
let kebayoran = Station(namaStasiun: "Kebayoran", latitude: -6.237247499999999, longitude: 106.7825225, isFavorite: 0)
let manggarai = Station(namaStasiun: "Manggarai", latitude: -6.2098886, longitude: 106.8502148, isFavorite: 0)
let palmerah = Station(namaStasiun: "Palmerah", latitude: -6.2074097, longitude: 106.7974369, isFavorite: 0)
let tanahAbang = Station(namaStasiun: "Tanah Abang", latitude: -6.185702099999999, longitude: 106.8108536, isFavorite: 0)
let karet = Station(namaStasiun: "Karet", latitude: -6.200803000000001, longitude: 106.8158467, isFavorite: 3)
let sudirman = Station(namaStasiun: "Sudirman", latitude: -6.202268399999999, longitude: 106.8231961, isFavorite: 0)
let cikini = Station(namaStasiun: "Cikini", latitude: -6.198556300000001, longitude: 106.8412633, isFavorite: 0)
let gondangdia = Station(namaStasiun: "Gondangdia", latitude: -6.186140000000001, longitude: 106.83266, isFavorite: 0)
let gambir = Station(namaStasiun: "Gambir", latitude: -6.1766472, longitude: 106.830608, isFavorite: 0)
let juanda = Station(namaStasiun: "Juanda", latitude: -6.1667216, longitude: 106.830473, isFavorite: 0)
let sawahBesar = Station(namaStasiun: "Sawah Besar", latitude: -6.16073, longitude: 106.82765, isFavorite: 0)
let manggaBesar = Station(namaStasiun: "Mangga Besar", latitude: -6.1498329, longitude: 106.8269677, isFavorite: 0)
let matraman = Station(namaStasiun: "Matraman", latitude: -6.212259299999999, longitude: 106.8603208, isFavorite: 0)
let jatinegara = Station(namaStasiun: "Jatinegara", latitude: -6.215096, longitude: 106.8702627, isFavorite: 0)
let tebet = Station(namaStasiun: "Tebet", latitude: -6.226111800000001, longitude: 106.8582931, isFavorite: 0)
let cawang = Station(namaStasiun: "Cawang", latitude: -6.242516899999999, longitude: 106.8587954, isFavorite: 0)
let durenKalibata = Station(namaStasiun: "Duren Kalibata", latitude: -6.2553371, longitude: 106.8550369, isFavorite: 0)
let pasarMingguBaru = Station(namaStasiun: "Pasar Minggu Baru", latitude: -6.262800299999999, longitude: 106.8518374, isFavorite: 0)
let pasarMinggu = Station(namaStasiun: "Pasar Minggu", latitude: -6.2842455, longitude: 106.8445464, isFavorite: 0)
let tanjungBaarat = Station(namaStasiun: "Tanjung Barat", latitude: -6.307807899999998, longitude: 106.8388453, isFavorite: 0)

var Hijau: [Station] = [
    pondokRanji,
    kebayoran,
    palmerah,
    tanahAbang
]

var BiruKiri: [Station] = [
    karet,
    sudirman,
    manggarai
]

var MerahAtas: [Station] = [
    manggarai,
    cikini,
    gondangdia,
    gambir,
    juanda,
    sawahBesar,
    manggaBesar
]

var BiruKanan: [Station] = [
    manggarai,
    matraman,
    jatinegara
]

var MerahBawah: [Station] = [
    manggarai,
    tebet,
    cawang,
    durenKalibata,
    pasarMingguBaru,
    pasarMinggu,
    tanjungBaarat
]
