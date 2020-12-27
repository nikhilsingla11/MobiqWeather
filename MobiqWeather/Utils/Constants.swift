//
//  HomeViewController.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

struct Constants {
    // Network Url
    static let prefixURLString = "https://api.openweathermap.org/data/2.5/forecast/daily?q="
    static let suffixURLString = "&cnt=5&APPID=c1cda13e755073432910d11a3e0d97ae"

    static let dateFormat = "dd MMM"
    static let homeCellId = "HomeListTableViewCellId"
    static let searchCellId = "SearchCityTableViewCellId"
}
