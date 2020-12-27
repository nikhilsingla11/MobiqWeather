//
//  Helper.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                    a = 1.0
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        } else {
            var hexNormalized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")
            
            var rgb: UInt64 = 0
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 1.0
            let length = hexNormalized.count
            
            Scanner(string: hexNormalized).scanHexInt64(&rgb)
            
            if length == 6 {
                r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                b = CGFloat(rgb & 0x0000FF) / 255.0
            } else if length == 8 {
                r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                a = CGFloat(rgb & 0x000000FF) / 255.0
            }
            self.init(red: r, green: g, blue: b, alpha: a)
        }
        
        return nil
    }
}
