//
//  Conversions.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import Foundation

class Conversion: NSObject {
    // temperature conversion
    static func convertToCelsius(fahrenheit: Double) -> String {
       var temp: Double = 0.0
       temp = fahrenheit - 273.15
       let celciusStr = String(format: "%.0f", temp)
       return celciusStr
    }
       
    // timestamp to Actual date convertor
    static func dateFormater(timeInterval: TimeInterval?) -> String {
       guard let interval = timeInterval else {
           return ""
       }
       let date = NSDate(timeIntervalSince1970: interval)
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = Constants.dateFormat
       let dateString = dateFormatter.string(from: date as Date)
       return dateString
    }
}
