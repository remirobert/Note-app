//
//  ToolbarPost.swift
//  App
//
//  Created by Remi Robert on 09/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ToolbarPost: UIToolbar {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        tintColor = UIColor.yellow
        barTintColor = UIColor.black
        isTranslucent = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
