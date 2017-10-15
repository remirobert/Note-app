//
//  SettingNodeControllerFactory.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import Wireframe
import UIKit

class SettingsNavigationControllerFactory: SettingsNavigationViewFactory {
    func make(rootView: View) -> NavigationView {
        guard let controller = rootView.viewController else {
            return SettingsNavigationController()
        }
        return SettingsNavigationController(rootViewController: controller)
    }
}

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

