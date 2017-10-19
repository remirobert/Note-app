//
//  ColorBarButtonItem.swift
//  App
//
//  Created by Remi Robert on 19/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class ColorBarButtonItem: UIButton {
    var color: UIColor = UIColor() {
        didSet {
            backgroundColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.size.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
