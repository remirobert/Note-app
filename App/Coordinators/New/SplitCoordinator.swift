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
    fileprivate var sliderCoordinator: SliderCoordinator!
    fileprivate let getDayUseCase: GetDayUseCase
    fileprivate let subscriber = PostUpdateSubscriber()
    fileprivate let navigationView: NavigationView
    fileprivate var navigationFeedView: NavigationView!

    init(window: Window) {
        self.window = window
        self.getDayUseCase = RMGetDayUseCase()
        let calendarViewModel = CalendarTextureViewModel(getDayUseCase: getDayUseCase,
                                                         postSubscriber: subscriber)
        calendarView = CalendarTextureControllerFactory(viewModel: calendarViewModel).make()
        navigationView = CalendarNavigationController(rootViewController: calendarView.viewController ?? UIViewController())

        let viewFactory = DayTextureControllerFactory()
        feedView = viewFactory.make()
        navigationFeedView = DayFeedNavigationViewFactory().make(rootView: feedView)
    }

    func start() {
        calendarView.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        window.rootView = splitViewController
        splitViewController.viewControllers = [navigationView.viewController!, navigationFeedView.viewController!]
        didSelectDay(date: Date())
    }
}

import AsyncDisplayKit

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
        feedView.viewModel = viewModel
        feedView.delegate = self
    }

    private func displayDayFeed() {
        
    }

    func displayDatePicker(type: DatePickerType, barButtonItem: UIBarButtonItem?) {
        let dateController = DatePickerViewController(type: type)
        dateController.delegate = calendarView.viewController as? CalendarTextureController
        dateController.modalPresentationStyle = .popover
        calendarView.present(view: dateController, animated: true)
        dateController.popoverPresentationController?.barButtonItem = barButtonItem
        dateController.popoverPresentationController?.permittedArrowDirections = .any
        dateController.preferredContentSize = CGSize(width: 300, height: 220)
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

    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect) {
        sliderCoordinator = SliderCoordinator(post: post,
                                              parentView: feedView,
                                              previewImage: image,
                                              rectImage: rect,
                                              startIndex: index)
        sliderCoordinator.start()
    }

    func updatePost(post: Post) {
        
    }
}
