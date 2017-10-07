//
//  CalendarNavigationController.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class CalendarNavigationController: UINavigationController {
    let toolBarActions = UIToolbar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.yellow
        navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)]
        view.addSubview(toolBarActions)

        toolBarActions.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        toolBarActions.tintColor = UIColor.yellow
        toolBarActions.barTintColor = UIColor.black
        toolBarActions.isTranslucent = true
    }
}
