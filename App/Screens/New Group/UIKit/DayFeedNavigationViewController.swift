
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
        navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.20, green:0.49, blue:0.96, alpha:1.00),
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.20, green:0.49, blue:0.96, alpha:1.00),
                                                      NSFontAttributeName: UIFont.systemFont(ofSize: 30, weight: UIFontWeightHeavy)]
        }
        navigationBar.shadowImage = UIImage()
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
