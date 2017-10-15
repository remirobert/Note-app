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
    private let settingsNavigationFactory: SettingsNavigationViewFactory
    private let parentView: View
    fileprivate var settingsView: SettingsView!

    init(parentView: View) {
        self.parentView = parentView
        settingsViewFactory = SettingNodeControllerFactory(settingsUseCase: RMGetAppSettingsUseCase(),
                                                           authProvider: LocalAuthentification())
        settingsNavigationFactory = SettingsNavigationControllerFactory()
    }

    func start() {
        guard let navigationView = parentView.navigationView else { return }
        settingsView = settingsViewFactory.make()
        settingsView.delegate = self
        let settingsNavigationView = settingsNavigationFactory.make(rootView: settingsView)
        settingsNavigationView.viewController?.modalPresentationStyle = .popover
        navigationView.present(view: settingsNavigationView, animated: true)
        let popController = settingsNavigationView.viewController?.popoverPresentationController!
        popController?.permittedArrowDirections = .any
        popController?.barButtonItem = parentView.viewController!.navigationItem.rightBarButtonItem
    }
}

extension SettingsCoordinator: SettingsViewDelegate {
    func dismiss() {
        settingsView.dismiss(animated: true)
    }
}
