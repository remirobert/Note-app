//
//  SettingNodeControllerFactory.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain

class SettingNodeControllerFactory: SettingsViewFactory {
    private let settingsViewModel: SettingsViewModel

    init(settingsUseCase: GetAppSettingsUseCase,
         authProvider: AuthentificationProvider) {
        self.settingsViewModel = SettingsViewModel(settingsUseCase: settingsUseCase,
                                                   authProvider: authProvider)
    }
    func make() -> SettingsView {
        return SettingsNodeController(viewModel: settingsViewModel)
    }
}

