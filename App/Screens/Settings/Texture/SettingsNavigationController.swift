//
//  SettingsNavigationController.swift
//  App
//
//  Created by Remi Robert on 15/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class SettingsNavigationController: UINavigationController {
    override func viewDidLoad() {
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.black
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
    }
}
