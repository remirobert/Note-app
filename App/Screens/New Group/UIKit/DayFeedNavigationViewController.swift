
//
//  DayFeedViewController.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Wireframe

class DayFeedNavigationViewFactory: NavigationViewFactory {
    func make(rootView: View) -> NavigationView {
        guard let viewController = rootView.viewController else {
            return UINavigationController()
        }
        return DayFeedNavigationViewController(rootViewController: viewController)
    }
}

class DayFeedNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor(red:0.35, green:0.63, blue:0.93, alpha:1.00)
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
