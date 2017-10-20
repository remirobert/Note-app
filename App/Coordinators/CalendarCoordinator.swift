//
//  CalendarCoordinator.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain
import RealmPlatform

class CalendarCoordinator {
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
        window.rootView = navigationView
    }
}

extension CalendarCoordinator: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        var dayModel: Day? = getDayUseCase.get(forDate: date)
        if dayModel == nil {
            dayModel = getDayUseCase.createNewDay(date: date)
        }
        guard let day = dayModel else { return }

        let op = RMPostOperationFactory(day: day)
        let viewModel = DayTextureViewModel(day: day, postsOperationProvider: op, subscriber: subscriber)
//        let deps = DayFeedCoordinator.Dependencies(day: day,
//                                                   parentView: calendarView,
//                                                   dayFeedFactory: DayTextureControllerFactory(viewModel: viewModel),
//                                                   dayNavigationFactory: DayFeedNavigationViewFactory())
//        dayFeedCoordinator = DayFeedCoordinator(dependencies: deps)
//        dayFeedCoordinator.start()
    }

    func displaySettings() {
        settingsCoordinator = SettingsCoordinator(parentView: calendarView)
        settingsCoordinator.start()
    }

    func displayDatePicker(type: DatePickerType, barButtonItem: UIBarButtonItem?) {
        
    }
}
