//
//  NavigationView+UIKit.swift
//  Wireframe
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension UINavigationController: NavigationView {
    public var navigationView: NavigationView? {
        return navigationController
    }

    public func push(view: View) {
        guard let viewController = view.viewController else { return }
        pushViewController(viewController, animated: true)
    }

    public func pop() {
        popViewController(animated: true)
    }
}
