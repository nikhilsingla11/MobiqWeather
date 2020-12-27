//
//  SettingsViewController.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 27/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var mapSwitch: UISwitch!
    @IBOutlet weak var maxTempSwitch: UISwitch!
    @IBOutlet weak var minTempSwitch: UISwitch!
    @IBOutlet weak var resetSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        mapSwitch.isOn = PermissionManager.isMapEnabled()
        maxTempSwitch.isOn = PermissionManager.isMaxTempEnabled()
        minTempSwitch.isOn = PermissionManager.isMinTempEnabled()
    }
}

//Actions
extension SettingsViewController {
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        UserDefaults.standard.set(mapSwitch.isOn, forKey: "isMapEnabled")
        UserDefaults.standard.set(maxTempSwitch.isOn, forKey: "isMaxTempEnabled")
        UserDefaults.standard.set(minTempSwitch.isOn, forKey: "isMinTempEnabled")
        if resetSwitch.isOn {
            UserDefaults.standard.set([], forKey: "bookmarked")
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "BookmarkedChanged"), object: nil, userInfo: nil)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

//Utils
extension SettingsViewController {
    static func instantiate() -> SettingsViewController? {
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Settings", bundle: nil)
        if let vc: SettingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsViewController {
            return vc
        }
        return nil
    }
}
