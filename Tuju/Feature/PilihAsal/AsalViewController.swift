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
    
    var recommend : [Stasiun] = [Stasiun]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nav bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))

        //search bar
        searchVC.searchBar.tag = 1
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.placeholder = "Departure Station"
        searchVC.searchBar.backgroundColor = .clear
        navigationItem.searchController = searchVC
        
        //table
        recommendationTable.delegate = self
        recommendationTable.dataSource = self
        recommendationTable.register(RecommendationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        //recommendation
        createRecommendArray()
        
    }
    
    @objc func cancelTapped(){
        dismiss(animated: true)
    }
    
    func createRecommendArray() {
        recommend.append(Stasiun(stasiunName: "Manggarai", stasiunDesc: "23km", lang: "", long: ""))
        recommend.append(Stasiun(stasiunName: "Palmerah", stasiunDesc: "1km", lang: "", long: ""))
        recommend.append(Stasiun(stasiunName: "Tanah Abang", stasiunDesc: "2km", lang: "", long: ""))
        recommend.append(Stasiun(stasiunName: "Duri", stasiunDesc: "10km", lang: "", long: ""))
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("Favorite", comment: "Favorite")
        case 1:
            sectionName = NSLocalizedString("Recent", comment: "Recent")
            // ...
        default:
            sectionName = "Recent"
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommend.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecommendationTableViewCell
        let currentLastItem = recommend[indexPath.row]
        cell.stasiun = currentLastItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


