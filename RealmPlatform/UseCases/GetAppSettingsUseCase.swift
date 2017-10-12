//
//  GetAppSettingsUseCase.swift
//  RealmPlatform
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import RealmSwift

public class RMGetAppSettingsUseCase: GetAppSettingsUseCase {
    private let configuration: Realm.Configuration

    public init(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.configuration = configuration
    }

    public func get() -> AppSettings {
        guard let realm = try? Realm(configuration: configuration) else {
            return AppSettings()
        }
        let id = String(describing: RMAppSettings.self)
        guard let savedSettings = realm.object(ofType: RMAppSettings.self, forPrimaryKey: id) else {
            return AppSettings()
        }
        return savedSettings.toAppSettings()
    }

    public func update(appSettings: AppSettings) {
        guard let realm = try? Realm(configuration: configuration) else {
            return
        }
        let object = appSettings.toRMAppSettings()
        try? realm.write {
            realm.add(object, update: true)
        }
    }
}
