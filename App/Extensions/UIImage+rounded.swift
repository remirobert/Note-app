//
//  UIImage+rounded.swift
//  App
//
//  Created by Remi Robert on 03/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension UIImage {
    func round(cornerSize: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let maskPath = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: UIRectCorner.allCorners,
                                    cornerRadii: cornerSize)
        maskPath.addClip()
        self.draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}
