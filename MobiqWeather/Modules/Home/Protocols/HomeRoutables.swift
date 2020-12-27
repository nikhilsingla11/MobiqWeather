//
//  HomeRoutables.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 27/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

protocol HomeRoutables {
    func routeToSearchScreen()
    func routeToCityScreen(cityName: String)
    func routeToSettingsScreen()
}
