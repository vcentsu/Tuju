//
//  AsalViewController.swift
//  Tuju
//
//  Created by Vincentius Sutanto on 13/10/22.
//

import UIKit

class AsalViewController: MapViewController {
    
    let searchVC = UISearchController()

    @IBOutlet weak var recommendationTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nav bar
        navigationItem.largeTitleDisplayMode = .always

        //search bar
        searchVC.searchBar.tag = 1
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.placeholder = "Destination"
        searchVC.searchBar.backgroundColor = .clear
        navigationItem.searchController = searchVC
        
        //table
        recommendationTable.delegate = self
        recommendationTable.dataSource = self
        recommendationTable.register(UINib(nibName: "RecommendationTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
}


extension AsalViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            return
        }
    
//        GooglePlacesManager.shared.findPlaces(query: query) { result in
//            switch result{
//            case .success(let places):
//                print(places)
//                print("Found Places")
//
//                DispatchQueue.main.async {
//                    self.places = places
//                    self.update()
//                }
//
//            case .failure(let error):
//                print(error)
//
//            }
//        }
    }
    
//    public func update(){
//        resultTable.isHidden = false
//        print(places.count)
//        resultTable.reloadData()
//    }
}

extension AsalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}


