//
//  AppDelegate.swift
//  App
//
//  Created by Remi Robert on 26/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private var coordinator: CalendarCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }

        IQKeyboardManager.sharedManager().enable = true

        window.makeKeyAndVisible()
//        let navigation = PostNavigationViewController(rootViewController: PostImageViewController())
//        window.rootViewController = navigation


        let factory = CalendarTextureControllerFactory()
        let deps = CalendarCoordinator.Dependencies(window: window, calendarViewFactory: factory)
        coordinator = CalendarCoordinator(dependencies: deps)
        coordinator.start()
        return true
    }
}

