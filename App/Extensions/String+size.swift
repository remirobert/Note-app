//
//  String+size.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension String {
    func size(textAttributes: [String:Any],
              width: CGFloat = UIScreen.main.bounds.size.width) -> CGSize {
        let attributedText = NSAttributedString(string: self, attributes: textAttributes)
        let size = CGSize(width: width,
                          height: CGFloat.infinity)
        let optionsDrawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin,
                                                             .usesFontLeading,
                                                             .usesDeviceMetrics]
        let heightText = attributedText.boundingRect(with: size,
                                                     options: optionsDrawingOptions,
                                                     context: nil).size.height
        return CGSize(width: width, height: ceil(heightText + 22.0))
    }
}
