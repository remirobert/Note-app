//
//  SettingsCoordinator.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Wireframe
import RealmPlatform

class SettingsCoordinator {
    private let settingsViewFactory: SettingsViewFactory
    private let parentView: View

    init(parentView: View) {
        self.parentView = parentView
        settingsViewFactory = SettingNodeControllerFactory(settingsUseCase: RMGetAppSettingsUseCase(),
                                                           authProvider: LocalAuthentification())
    }

    func start() {
        guard let navigationView = parentView.navigationView else { return }
        let settingsView = settingsViewFactory.make()
        navigationView.push(view: settingsView)
    }
}
