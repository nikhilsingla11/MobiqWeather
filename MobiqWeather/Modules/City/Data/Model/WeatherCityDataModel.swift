//
//  WeatherDataModel.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

struct CityDataModel: Decodable {
    var city: CityModel?
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [ListDataModel]?
}

struct CityModel: Decodable {
    var id: Double?
    var name: String?
    var coord: CoordinateModel?
    var country: String?
    var population: Double?
    var timezone: Double?
}

struct CoordinateModel: Decodable {
    var lat: Double?
    var lon: Double?
}

struct ListDataModel: Decodable {
    var dt: Double?
    var sunrise: Double?
    var sunset: Double?
    var pressure: Int?
    var humidity: Int?
    var weather: [WeatherModel]?
    var temp: TemperatureModel?
    var speed: Double?
    var deg: Double?
    var clouds: Double?
}

struct TemperatureModel: Decodable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}

struct WeatherModel: Decodable {
    var id: Double?
    var main: String?
    var description: String?
    var icon: String?
}
