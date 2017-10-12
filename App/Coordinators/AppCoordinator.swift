//
//  AppCoordinator.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

class AppCoordinator: NSObject {
    private let window: Window
    private let calendarCoordinator: CalendarCoordinator
    private var authCoordinator: AuthentificationCoordinator!

    init(window: Window) {
        self.window = window
        self.calendarCoordinator = CalendarCoordinator(window: window)
        self.authCoordinator = AuthentificationCoordinator(window: window)
    }

    func start() {
        calendarCoordinator.start()
        authCoordinator.start()
    }
}
