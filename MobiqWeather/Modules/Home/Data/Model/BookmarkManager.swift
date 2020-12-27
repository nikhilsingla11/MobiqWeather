//
//  BookmarkManager.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 27/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

class BookmarkManager {
    static func getBookmarkedCities() -> [AnnotationModel]? {
        if let bookmarkedCities = UserDefaults.standard.value(forKey: "bookmarked") as? [[String: String]] {
            var dict: [AnnotationModel] = []
            for item in bookmarkedCities {
                dict.append(AnnotationModel(city: item["city"] ?? "", longitude: item["longitude"] ?? "", latitude: item["latitude"] ?? ""))
            }
            return dict
        }
        return nil
    }
    
    static func isCityBookmarked(model: AnnotationModel) -> Bool {
        if let bookmarkedCities = BookmarkManager.getBookmarkedCities() {
            if bookmarkedCities.firstIndex(where: { $0.city == model.city }) != nil {
                return true
            }
            return false
        }
        return false
    }
    
    static func editBookmarkedCities(model: AnnotationModel) {
        var bookmarkedCities = BookmarkManager.getBookmarkedCities() ?? []
        if let index = bookmarkedCities.firstIndex(where: { $0.city == model.city }) {
            bookmarkedCities.remove(at: index)
        } else {
           bookmarkedCities.append(model)
        }
        var dict: [[String: String]] = []
        for item in bookmarkedCities {
            dict.append(["city": item.city, "longitude": item.longitude, "latitude": item.latitude])
        }
        UserDefaults.standard.set(dict, forKey: "bookmarked")
    }
}
