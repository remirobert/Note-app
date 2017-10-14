//
//  SplitCoordinator.swift
//  App
//
//  Created by Remi Robert on 14/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Wireframe
import Domain
import RealmPlatform

extension UISplitViewController: View {}

class SplitCoordinator {
    fileprivate let splitViewController = UISplitViewController()
    fileprivate let window: Window
    fileprivate let calendarView: CalendarView
    fileprivate var dayFeedCoordinator: DayFeedCoordinator!
    fileprivate var settingsCoordinator: SettingsCoordinator!
    fileprivate let getDayUseCase: GetDayUseCase
    fileprivate let subscriber = PostUpdateSubscriber()
    fileprivate let navigationView: NavigationView

    init(window: Window) {
        self.window = window
        self.getDayUseCase = RMGetDayUseCase()
        let calendarViewModel = CalendarTextureViewModel(getDayUseCase: getDayUseCase,
                                                         postSubscriber: subscriber)
        calendarView = CalendarTextureControllerFactory(viewModel: calendarViewModel).make()
        navigationView = CalendarNavigationController(rootViewController: calendarView.viewController ?? UIViewController())
    }

    func start() {
        calendarView.delegate = self

        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        splitViewController.preferredDisplayMode = .allVisible

        splitViewController.viewControllers = [navigationView.viewController!, vc]
        window.rootView = splitViewController
        print("🅰️ split : \(splitViewController.viewController)")
    }
}

extension SplitCoordinator: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        var dayModel: Day? = getDayUseCase.get(forDate: date)
        if dayModel == nil {
            dayModel = getDayUseCase.createNewDay(date: date)
        }
        guard let day = dayModel else { return }

        let op = RMFetchPostOperationFactory(day: day)
        let viewModel = DayTextureViewModel(day: day, postsOperationProvider: op, subscriber: subscriber)
        let viewFactory = DayTextureControllerFactory(viewModel: viewModel)
        let deps = DayFeedCoordinator.Dependencies(day: day,
                                                   parentView: calendarView,
                                                   dayFeedFactory: DayTextureControllerFactory(viewModel: viewModel),
                                                   dayNavigationFactory: DayFeedNavigationViewFactory())

        dayFeedCoordinator = DayFeedCoordinator(dependencies: deps)
//        dayFeedCoordinator.start()
        let feedView = DayFeedNavigationViewFactory().make(rootView: viewFactory.make())
        splitViewController.showDetailViewController(feedView.viewController!, sender: nil)
    }

    private func displayDayFeed() {
        
    }

    func displaySettings() {
        settingsCoordinator = SettingsCoordinator(parentView: calendarView)
        settingsCoordinator.start()
    }
}
