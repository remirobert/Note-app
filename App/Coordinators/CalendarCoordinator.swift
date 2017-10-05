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
    fileprivate let subscriber = PostUpdateSubscriber()
    fileprivate let navigationView: NavigationView

    struct Dependencies {
        let window: Window
        let calendarViewFactory: CalendarViewFactory
    }

    init(dependencies: Dependencies) {
        self.getDayUseCase = RMGetDayUseCase()
        self.dependencies = dependencies
        let controller = dependencies.calendarViewFactory.make()
        calendarView = controller
        navigationView = CalendarNavigationController(rootViewController: controller.viewController ?? UIViewController())
    }

    func start() {
        calendarView.delegate = self
        dependencies.window.rootView = navigationView
    }
}

extension CalendarCoordinator: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        var dayModel: Day? = getDayUseCase.get(forDate: date)
        if dayModel == nil {
            dayModel = getDayUseCase.createNewDay(date: date)
        }
        guard let day = dayModel else { return }

        let op = RMFetchPostOperationFactory(day: day)
        let viewModel = DayTextureViewModel(day: day, postsOperationProvider: op, subscriber: subscriber)
        let deps = DayFeedCoordinator.Dependencies(day: day,
                                                   parentView: calendarView,
                                                   dayFeedFactory: DayTextureControllerFactory(viewModel: viewModel),
                                                   dayNavigationFactory: DayFeedNavigationViewFactory())
        dayFeedCoordinator = DayFeedCoordinator(dependencies: deps)
        dayFeedCoordinator.start()
    }
}
