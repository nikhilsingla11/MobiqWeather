//
//  Constants.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import Foundation

struct Constants {
    // Network Url
    static let prefixURLString = "https://api.openweathermap.org/data/2.5/forecast/daily?q="
    static let suffixURLString = "&cnt=14&APPID=c1cda13e755073432910d11a3e0d97ae"

    static let dateFormat = "dd-MMM-yyyy"
    static let cellId = "CityWeatherTableViewCellId"
}
