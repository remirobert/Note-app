//
//  SettingsViewModel.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import AsyncDisplayKit

protocol SettingsViewModelDelegate: class {
    func reloadSettingsItems()
}

class SettingsViewModel {
    fileprivate let settingsUseCase: GetAppSettingsUseCase
    private var authProvider: AuthentificationProvider
    fileprivate let appSettings: AppSettings

    private(set) var touchIdSettingItem = SettingItem()

    weak var delegate: SettingsViewModelDelegate?

    init(settingsUseCase: GetAppSettingsUseCase,
         authProvider: AuthentificationProvider) {
        self.settingsUseCase = settingsUseCase
        self.authProvider = authProvider
        self.appSettings = self.settingsUseCase.get()
        self.authProvider.delegate = self
        updateSettingsItem()
    }

    fileprivate func updateSettingsItem() {
        touchIdSettingItem = SettingItem(name: "Touch ID", description: "Protect your datas with touch Id. Everytime you launch the app, touch ID will be ask to unlock it.", switchValue: appSettings.localAuthEnabled)
    }

    func didUpdateTouchId(value: Bool) {
        print("value : \(value)")
        if !value {
            appSettings.localAuthEnabled = false
            settingsUseCase.update(appSettings: appSettings)
            updateSettingsItem()
            delegate?.reloadSettingsItems()
            return
        }
        authProvider.authentificate()
    }
}

extension SettingsViewModel: AuthentificationProviderDelegate {
    func authenticated(success: Bool) {
        if success {
            appSettings.localAuthEnabled = true
            settingsUseCase.update(appSettings: appSettings)
        }
        updateSettingsItem()
        if !success {
            delegate?.reloadSettingsItems()
        }
    }
}
