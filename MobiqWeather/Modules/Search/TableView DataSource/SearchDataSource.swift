//
//  SearchDataSource.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
      weak var context: SearchViewController?
      var data: [AnnotationModel] = []
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchCellId) as? SearchCityTableViewCell else {return UITableViewCell()}
          cell.setupView(model: data[indexPath.row])
          return cell
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 52.0
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cityVC: CityViewController = CityViewController.instantiate(city: data[indexPath.row].city) else { return }
          context?.navigationController?.pushViewController(cityVC, animated: true)
      }
      
      func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
          return 0.01
      }
}
