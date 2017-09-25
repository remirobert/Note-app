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
}

public extension View {
    public func present(view: View) {
        guard let controller = view.viewController else { return }
        viewController?.present(controller, animated: true, completion: nil)
    }

    public func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
