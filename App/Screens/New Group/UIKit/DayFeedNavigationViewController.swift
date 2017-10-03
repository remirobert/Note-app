
//
//  DayFeedViewController.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Wireframe
import SnapKit

class DayFeedNavigationViewFactory: NavigationViewFactory {
    func make(rootView: View) -> NavigationView {
        guard let viewController = rootView.viewController else {
            return UINavigationController()
        }
        return DayFeedNavigationViewController(rootViewController: viewController)
    }
}

class DayFeedNavigationViewController: UINavigationController {
    let toolBarActions = UIToolbar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.black
        navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.lightGray,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.lightGray,
                                                      NSFontAttributeName: UIFont.systemFont(ofSize: 30, weight: UIFontWeightHeavy)]
        }
        navigationBar.shadowImage = UIImage()
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }

        view.addSubview(toolBarActions)
        toolBarActions.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        toolBarActions.tintColor = UIColor(red:0.20, green:0.84, blue:0.61, alpha:1.00)
        toolBarActions.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
        toolBarActions.isTranslucent = true
    }
}
