//
//  SplitViewCoordinator.swift
//  App
//
//  Created by Remi Robert on 17/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain
import RealmPlatform

class SplitViewCoordinator {
    private let window: Window
    fileprivate let subscriber = PostUpdateSubscriber()
    fileprivate let splitViewController = UISplitViewController()

    fileprivate let calendarCoordinator: CalendarCoordinatorNew
    fileprivate let dayFeedCoordinator: DayFeedCoordinatorNew

    init(window: Window) {
        self.window = window
        self.calendarCoordinator = CalendarCoordinatorNew(subscriber: subscriber)
        self.dayFeedCoordinator = DayFeedCoordinatorNew(subscriber: subscriber)
    }

    func start() {
        splitViewController.preferredDisplayMode = .allVisible
        calendarCoordinator.delegate = self
        splitViewController.viewControllers = [calendarCoordinator.navigationView.viewController!,
                                               dayFeedCoordinator.navigationView.viewController!]
        calendarCoordinator.didSelectDay(date: Date())
        window.rootView = splitViewController
    }
}

extension SplitViewCoordinator: CalendarCoordinatorNewDelegate {
    func loadNewDetailDay(day: Day) {
        dayFeedCoordinator.loadDay(day: day)
        splitViewController.showDetailViewController(dayFeedCoordinator.navigationView.viewController!, sender: nil)
    }
}
