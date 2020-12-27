//
//  HomeRouter.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 27/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

class HomeRouter: HomeRoutables {
    weak var context: HomeViewController?
    
    func routeToSearchScreen() {
        guard let searchVC: SearchViewController = SearchViewController.instantiate() else { return }
        context?.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func routeToCityScreen(cityName: String) {
        guard let cityVC: CityViewController = CityViewController.instantiate(city: cityName) else { return }
        context?.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    func routeToSettingsScreen() {
        guard let settingsVC: SettingsViewController = SettingsViewController.instantiate() else { return }
        context?.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
