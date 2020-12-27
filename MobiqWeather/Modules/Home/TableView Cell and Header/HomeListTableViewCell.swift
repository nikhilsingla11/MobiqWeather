//
//  HomeListTableViewCell.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCityName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(model: AnnotationModel) {
        lblCityName.text = model.city
    }
}
