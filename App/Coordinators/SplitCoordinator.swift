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
    fileprivate var currentDay: Day!
    fileprivate let splitViewController = UISplitViewController()
    fileprivate let window: Window
    fileprivate let calendarView: CalendarView
    fileprivate var feedView: DayFeedView!
    fileprivate var settingsCoordinator: SettingsCoordinator!
    fileprivate var postCoordinator: PostCoordinator!
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
        vc.view.backgroundColor = UIColor.white
        splitViewController.preferredDisplayMode = .allVisible

        splitViewController.viewControllers = [navigationView.viewController!, vc]
        window.rootView = splitViewController
        print("🅰️ split : \(splitViewController.viewController)")
        didSelectDay(date: Date())
    }
}

extension SplitCoordinator: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        if let currentDay = self.currentDay, currentDay.date == date {
            return
        }
        var dayModel: Day? = getDayUseCase.get(forDate: date)
        if dayModel == nil {
            dayModel = getDayUseCase.createNewDay(date: date)
        }
        guard let day = dayModel else { return }
        currentDay = day

        let op = RMFetchPostOperationFactory(day: day)
        let viewModel = DayTextureViewModel(day: day, postsOperationProvider: op, subscriber: subscriber)
        let viewFactory = DayTextureControllerFactory(viewModel: viewModel)
        feedView = viewFactory.make()
        let navigationView = DayFeedNavigationViewFactory().make(rootView: feedView)
        feedView.delegate = self
        splitViewController.showDetailViewController(navigationView.viewController!, sender: nil)
    }

    private func displayDayFeed() {
        
    }

    func displaySettings() {
        settingsCoordinator = SettingsCoordinator(parentView: calendarView)
        settingsCoordinator.start()
    }
}

extension SplitCoordinator: DayFeedViewDelegate {
    func addPost() {
        postCoordinator = nil
        postCoordinator = PostCoordinator(day: currentDay,
                                          parentView: feedView)
        postCoordinator.start()
    }

    func displayCalendarView() {

    }

    func displaySlider(post: PostImage, index: Int, image: UIImage?, rect: CGRect) {

    }
}
