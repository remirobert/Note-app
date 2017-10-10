//
//  SliderNavigationController.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class SliderNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.black
        view.backgroundColor = UIColor.clear
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.yellow,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
