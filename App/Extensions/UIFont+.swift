//
//  UIFont+.swift
//  App
//
//  Created by Remi Robert on 30/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

enum AppFont: String {
    case normalText = "WorkSans-Regular"
}

extension UIFont {
    static func custom(name: AppFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name.rawValue, size: size) else {
            fatalError("custom app font not found : \(name.rawValue)")
        }
        return font
    }
}
