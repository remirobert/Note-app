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
    fileprivate let dependencies: Dependencies
    fileprivate let calendarView: CalendarView
    fileprivate var dayFeedCoordinator: DayFeedCoordinator!
    fileprivate let getDayUseCase: GetDayUseCase

    struct Dependencies {
        let window: Window
        let calendarViewFactory: CalendarViewFactory
    }

    init(dependencies: Dependencies) {
        self.getDayUseCase = RMGetDayUseCase()
        self.dependencies = dependencies
        calendarView = dependencies.calendarViewFactory.make()
    }

    func start() {
        calendarView.delegate = self
        dependencies.window.rootView = calendarView
    }
}

extension CalendarCoordinator: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        let day = getDayUseCase.get(forDate: date)

        let op = RMFetchPostOperationFactory(day: day)
        let viewModel = DayFeedViewModel(day: day, postsOperationProvider: op)
        let deps = DayFeedCoordinator.Dependencies(day: day,
                                                   parentView: calendarView,
                                                   dayFeedFactory: DayFeedViewControllerFactory(viewModel: viewModel),
                                                   dayNavigationFactory: DayFeedNavigationViewFactory())
        dayFeedCoordinator = DayFeedCoordinator(dependencies: deps)
        dayFeedCoordinator.start()
    }
}
