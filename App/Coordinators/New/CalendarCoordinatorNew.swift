//
//  CalendarCoordinatorNew.swift
//  App
//
//  Created by Remi Robert on 17/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import Wireframe
import RealmPlatform

protocol CalendarCoordinatorNewDelegate: class {
    func loadNewDetailDay(day: Day)
}

class CalendarCoordinatorNew {
    fileprivate var currentDay: Day!
    fileprivate let getDayUseCase = RMGetDayUseCase()
    fileprivate var settingsCoordinator: SettingsCoordinator!
    let calendarView: CalendarView
    let navigationView: NavigationView

    weak var delegate: CalendarCoordinatorNewDelegate?

    init(subscriber: PostUpdateSubscriber) {
        let calendarViewModel = CalendarTextureViewModel(getDayUseCase: getDayUseCase,
                                                         postSubscriber: subscriber)
        calendarView = CalendarTextureControllerFactory(viewModel: calendarViewModel).make()
        navigationView = CalendarNavigationController(rootViewController: calendarView.viewController ?? UIViewController())
        calendarView.delegate = self
    }
}

extension CalendarCoordinatorNew: CalendarViewDelegate {
    func didSelectDay(date: Date) {
        if let currentDay = self.currentDay, currentDay.date == date {
            return
        }
        let dayModel = getDayUseCase.get(forDate: date)
        currentDay = dayModel
        delegate?.loadNewDetailDay(day: dayModel)
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
