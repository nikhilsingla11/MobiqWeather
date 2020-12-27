//
//  MobiqButton.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

@objc class MobiqButton: UIButton {
    @IBInspectable var buttonTintColor: UIColor = .white {
        didSet {
            tintColor = buttonTintColor
        }
    }
}
