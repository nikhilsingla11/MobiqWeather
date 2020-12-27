//
//  HomeDataSource.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class HomeDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var context: HomeViewController?
    var data: [AnnotationModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeCellId) as? HomeListTableViewCell else {return UITableViewCell()}
        cell.setupView(model: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context?.router.routeToCityScreen(cityName: data[indexPath.row].city)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeBookmark = UIContextualAction(style: .destructive, title: "Remove") {  (contextualAction, view, boolValue) in
            BookmarkManager.editBookmarkedCities(model: self.data[indexPath.row])
            self.context?.removeBookmarkFromList(model: self.data[indexPath.row])
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [removeBookmark])
        return swipeActions
    }
    
}
