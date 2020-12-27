//
//  NetworkManager.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    func fetchCityData(cityName: String, copmletion: @escaping(Result<[WeatherCityViewModel], Error>) -> ()) {
        let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = String(format: "%@%@%@",
                               Constants.prefixURLString, city ?? "", Constants.suffixURLString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _error = error {
                copmletion(.failure(_error))
            }
            guard let data = data else { return }
            do {
                let cityDataModel = try JSONDecoder().decode(CityDataModel.self, from: data)
                var weatherCityViewModel: [WeatherCityViewModel] = []
                if let list = cityDataModel.list {
                    for i in 0 ..< list.count {
                        weatherCityViewModel.append(WeatherCityViewModel(model: cityDataModel, index: i))
                    }
                }
                copmletion(.success(weatherCityViewModel))
            } catch let jsonError {
                copmletion(.failure(jsonError))
            }
        }.resume()
    }
}
