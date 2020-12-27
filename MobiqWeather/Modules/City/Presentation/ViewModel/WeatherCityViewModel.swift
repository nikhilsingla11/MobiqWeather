//
//  WeatherCityViewModel.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

class WeatherCityViewModel {
    var model: CityDataModel?
    var index: Int?
    
    init(model: CityDataModel, index: Int) {
        self.model = model
        self.index = index
    }
    
    deinit {
        model = nil
        index = nil
    }
    
    func getCityName() -> String? {
        return model?.city?.name
    }
    
    func getCityWeather() -> String? {
        return model?.list?[index ?? 0].weather?.first?.description?.capitalized
    }
    
    func getDate() -> String? {
        return Conversion.dateFormater(timeInterval: TimeInterval(exactly: model?.list?[index ?? 0].dt ?? 0.0))
    }
    
    func getMinTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].temp?.min ?? 0.0) + "°"
    }
    
    func getMaxTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].temp?.max ?? 0.0) + "°"
    }
    
    func getTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].temp?.day ?? 0.0) + "°"
    }
    
    func getFeelsLikeTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].feels_like?.day ?? 0.0) + "°"
    }
    
    func getHumidity() -> String? {
        return String(model?.list?[index ?? 0].humidity ?? 0) + "%"
    }
    
    func getCloudCover() -> String? {
        return String(model?.list?[index ?? 0].clouds ?? 0) + "%"
    }
    
    func getWindSpeed() -> String? {
        return String(model?.list?[index ?? 0].speed ?? 0) + "m/s"
    }
}
