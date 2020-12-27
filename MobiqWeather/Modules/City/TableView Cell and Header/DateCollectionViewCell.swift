//
//  DateCollectionViewCell.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(viewModel: WeatherCityViewModel, isSelected: Bool) {
        lblDate.text = viewModel.getDate()
        lblTemp.text = viewModel.getTemp()
        lblWeather.text = viewModel.getCityWeather()
        if isSelected {
            lblDate.textColor = UIColor.init(hexString: "#64b5f6")
            lblTemp.textColor = UIColor.init(hexString: "#64b5f6")
        } else {
            lblDate.textColor = .black
            lblTemp.textColor = .black
        }
    }

}
