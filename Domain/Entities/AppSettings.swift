//
//  Settings.swift
//  Domain
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

public class AppSettings {
    public var localAuthEnabled: Bool

    public init(localAuthEnabled: Bool = false) {
        self.localAuthEnabled = localAuthEnabled
    }
}
