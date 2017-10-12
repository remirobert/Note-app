//
//  View+UIKit.swift
//  Pods
//
//  Created by Remi Robert on 24/08/2017.
//
//

import UIKit

public extension View {
    var viewController: UIViewController? {
        return self as? UIViewController
    }

    public var navigationView: NavigationView? {
        return viewController?.navigationController
    }
}

public extension View {
    public func present(view: View, animated: Bool) {
        guard let controller = view.viewController else { return }
        viewController?.present(controller, animated: animated, completion: nil)
    }

    public func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated, completion: nil)
    }
}
