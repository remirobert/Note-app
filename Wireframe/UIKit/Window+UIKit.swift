//
//  Window+UIKit.swift
//  Pods
//
//  Created by Remi Robert on 24/08/2017.
//
//

import UIKit

extension UIWindow: Window {
    public var rootView: View? {
        set {
            rootViewController = newValue?.viewController
        }
        get {
            return rootViewController as? View
        }
    }
}
