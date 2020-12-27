//
//  SearchCityTableViewCell.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class SearchCityTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    var isBookmarked = false
    var model: AnnotationModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(model: AnnotationModel) {
        self.model = model
        lblCityName.text = model.city
        isBookmarked = BookmarkManager.isCityBookmarked(model: model)
        setBtnImage()
    }
    func setBtnImage() {
        if isBookmarked {
            btnBookmark.setImage(UIImage(named: "StarFilled"), for: .normal)
        } else {
            btnBookmark.setImage(UIImage(named: "Star"), for: .normal)
        }
    }
    @IBAction func btnBookmarkClicked(_ sender: Any) {
        if let _model = model {
            BookmarkManager.editBookmarkedCities(model: _model)
        }
        isBookmarked = !isBookmarked
        setBtnImage()
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "BookmarkedChanged"), object: nil, userInfo: nil)
    }
}
