//
//  GetAppSettingsUseCase.swift
//  Domain
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol GetAppSettingsUseCase: class {
    func get() -> AppSettings
    func update(appSettings: AppSettings)
}
