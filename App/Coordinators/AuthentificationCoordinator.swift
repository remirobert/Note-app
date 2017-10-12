//
//  AuthentificationCoordinator.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

class AuthentificationCoordinator {
    private let window: Window
    fileprivate let authentificationView: AuthentificationView

    init(window: Window) {
        self.window = window
        self.authentificationView = AuthentificationViewControllerFactory().make()
        self.authentificationView.delegate = self
    }

    func start() {
        guard let rootView = window.rootView else {
            window.rootView = authentificationView
            return
        }
        rootView.present(view: authentificationView, animated: false)
    }
}

extension AuthentificationCoordinator: AuthentificationViewDelegate {
    func authentificationSuccess() {
        authentificationView.dismiss(animated: false)
    }
}
