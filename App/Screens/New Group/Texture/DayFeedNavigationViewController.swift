
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
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.lightGray,
                                                      NSFontAttributeName: UIFont.systemFont(ofSize: 30, weight: UIFontWeightHeavy)]
        }
        navigationBar.shadowImage = UIImage()

        view.addSubview(toolBarActions)
        toolBarActions.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        toolBarActions.tintColor = UIColor.yellow
        toolBarActions.barTintColor = UIColor.black
        toolBarActions.isTranslucent = true
    }
}
