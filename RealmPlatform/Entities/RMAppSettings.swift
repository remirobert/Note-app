//
//  RMAppSettings.swift
//  RealmPlatform
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

public class RMAppSettings: Object {
    public dynamic var id: String = String(describing: RMAppSettings.self)
    public dynamic var localAuthEnabled: Bool = false

    public convenience init(localAuthEnabled: Bool) {
        self.init()
        self.localAuthEnabled = localAuthEnabled
    }

    public override class func primaryKey() -> String? {
        return "id"
    }
}

extension AppSettings {
    public func toRMAppSettings() -> RMAppSettings {
        return RMAppSettings(localAuthEnabled: self.localAuthEnabled)
    }
}

extension RMAppSettings {
    public func toAppSettings() -> AppSettings {
        return AppSettings(localAuthEnabled: self.localAuthEnabled)
    }
}

