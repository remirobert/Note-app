//
//  SettingItem.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class SettingItem {
    let name: String
    let description: String
    let switchValue: Bool

    init(name: String = String(),
        description: String = String(),
        switchValue: Bool = false) {
        self.name = name
        self.description = description
        self.switchValue = switchValue
    }
}