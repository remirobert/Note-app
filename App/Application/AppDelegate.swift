//
//  AppDelegate.swift
//  App
//
//  Created by Remi Robert on 26/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RealmPlatform

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private var appCoordinator: SplitViewCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }
        
        RMConfiguration.shared.login()

        IQKeyboardManager.sharedManager().enable = true
        window.makeKeyAndVisible()
        appCoordinator = SplitViewCoordinator(window: window)
        appCoordinator.start()
        return true
    }
}

