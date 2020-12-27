//
//  PermissionManager.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 27/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import Foundation

class PermissionManager {
    static func isMapEnabled() -> Bool {
        if let isMapEnabled = UserDefaults.standard.value(forKey: "isMapEnabled") as? Bool {
            return isMapEnabled
        }
        return true
    }
    
    static func isMaxTempEnabled() -> Bool {
        if let isMaxTempEnabled = UserDefaults.standard.value(forKey: "isMaxTempEnabled") as? Bool {
            return isMaxTempEnabled
        }
        return true
    }
    
    static func isMinTempEnabled() -> Bool {
        if let isMinTempEnabled = UserDefaults.standard.value(forKey: "isMinTempEnabled") as? Bool {
            return isMinTempEnabled
        }
        return true
    }
}
