//
//  CalendarTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

protocol CalendarTextureViewModelDelegate: class {
    func reloadCalendarSections()
}

class CalendarTextureViewModel {
    private let currentDate: Date
    fileprivate var dateSelected: Date
    let currentDateData: DateData
    private(set) var currentDisplayedYear: Int = 0
    private let calendar: Calendar
    private let getDayUseCase: GetDayUseCase

    private(set) var sections = [SectionCalendar]()
    private(set) var todaySection: SectionCalendar!
    private(set) var currentSection: IndexPath?
    private(set) var loadedSection: IndexPath?

    weak var delegate: CalendarTextureViewModelDelegate?

    init(currentDate: Date = Date(),
         calendar: Calendar = Calendar.current,
         getDayUseCase: GetDayUseCase,
         postSubscriber: PostSubscriber) {
        self.getDayUseCase = getDayUseCase
        self.currentDate = currentDate
        self.dateSelected = currentDate
        self.calendar = calendar
        self.currentDateData = DateData(date: currentDate, calendar: calendar)
        initInitialData()
        postSubscriber.addSubscriber(object: self)
    }

    private func initInitialData() {
        loadYear(fromDate: Date())
    }

    func loadYear(fromDate date: Date) {
        let year = calendar.component(Calendar.Component.year, from: date)
        let month = calendar.component(Calendar.Component.month, from: date)
        let day = calendar.component(Calendar.Component.day, from: date)
        dateSelected = date
        currentDisplayedYear = year
        currentSection = nil
        loadedSection = nil
        sections.removeAll(keepingCapacity: true)
        calendar.monthSymbols.enumerated().forEach { index, _ in
            let dateData = DateData(month: index, year: year)
            let sectionCalendar = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
            if currentDateData.month + 1 == index && currentDateData.year == year {
                currentSection = IndexPath(row: 0, section: index)
                sectionCalendar.setCurrentDay(day: day)
            }
            if month == index {
                loadedSection = IndexPath(row: 0, section: index)
            }
            sections.insert(sectionCalendar, at: 0)
        }
        sections.reverse()
        delegate?.reloadCalendarSections()
    }
}

extension CalendarTextureViewModel: PostUpdateSubscriberDelegate {
    func dataDidUpdate() {
        print("🈷 🌀 get update notification")
        loadYear(fromDate: dateSelected)
    }
}
