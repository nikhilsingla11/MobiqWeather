//
//  SearchViewController.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private weak var tableVwSearch: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var lblError: UILabel!
    lazy var dataSource: SearchDataSource = SearchDataSource()
    private var defaultCityList: [AnnotationModel] = []
    private var filteredArray: [AnnotationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupDefaultCities()
        checkError()
        searchBar.delegate = self
    }

    private func setupTableview() {
        registerNib()
        dataSource.context = self
        tableVwSearch.dataSource = dataSource
        tableVwSearch.delegate = dataSource
    }
    
    private func registerNib() {
        tableVwSearch.register(UINib(nibName: "SearchCityTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.searchCellId)
    }
    
    func setupDefaultCities() {
        guard let url = Bundle.main.url(forResource: "PopularCities", withExtension: "plist"), let cityArray = NSArray(contentsOf: url) as? [[String: String]] else { return }
        var populardefaultCityList: [AnnotationModel] = []
        for item in cityArray {
            let cityAnnotation = AnnotationModel(city: item["city"] ?? "", longitude: item["longitude"] ?? "", latitude: item["latitude"] ?? "")
            populardefaultCityList.append(cityAnnotation)
        }
        defaultCityList = populardefaultCityList
        filteredArray = populardefaultCityList
        dataSource.data = filteredArray
        tableVwSearch.reloadData()
    }
    
    private func checkError() {
        if filteredArray.count == 0 {
            lblError.isHidden = false
        } else {
            lblError.isHidden = true
        }
    }
}

//Actions
extension SearchViewController {
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//Utils
extension SearchViewController {
    static func instantiate() -> SearchViewController? {
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Search", bundle: nil)
        if let vc: SearchViewController = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? SearchViewController {
            return vc
        }
        return nil
    }
}

// Search bar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCities(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filteredArray = defaultCityList
        dataSource.data = filteredArray
        tableVwSearch.reloadData()
    }
    
    func filterCities(text: String) {
        if text == "" {
            filteredArray = defaultCityList
        } else {
            let cityArr = defaultCityList.filter { (item) -> Bool in
                return item.city.contains(text)
            }
            filteredArray = cityArr
        }
        dataSource.data = filteredArray
        checkError()
        tableVwSearch.reloadData()
    }
}
