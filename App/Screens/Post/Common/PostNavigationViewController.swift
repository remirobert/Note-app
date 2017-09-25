//
//  PostNavigationViewController.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Wireframe

class PostNavigationViewControllerFactory: NavigationViewFactory {
    func make(rootView: View) -> NavigationView {
        guard let rootController = rootView.viewController else {
            return UINavigationController()
        }
        return PostNavigationViewController(rootViewController: rootController)
    }
}

class PostNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.black
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
    }
}
