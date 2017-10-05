//
//  CalendarTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

class SectionCalendar {
    let month: Int
    let year: Int
    private(set) var days = [DateData]()
    private let getDayUseCase: GetDayUseCase
    var dateData: DateData {
        return DateData(day: 0, month: month, year: year)
    }

    init(month: Int, year: Int, getDayUseCase: GetDayUseCase) {
        self.getDayUseCase = getDayUseCase
        self.month = month
        self.year = year
        initDaysData()
    }

    init(dateData: DateData, getDayUseCase: GetDayUseCase) {
        self.getDayUseCase = getDayUseCase
        self.month = dateData.month
        self.year = dateData.year
        initDaysData()
    }

    private func initDaysData() {
        let dayCount = Date.daysCount(year: year, month: month + 1)
        days = (1...dayCount).map({ (day: Int) -> DateData in
            let date = Date.fromComponents(day: day, month: month + 1, year: year)
            let dayModel = getDayUseCase.get(forDate: date)
            return DateData(day: day, month: month, year: year, dayModel: dayModel)
        })
    }
}

extension SectionCalendar: Equatable {
    static func ==(lhs: SectionCalendar, rhs: SectionCalendar) -> Bool {
        return lhs.month == rhs.month && lhs.year == rhs.year
    }
}

class CalendarTextureViewModel {
    private let currentDate: Date
    private let calendar: Calendar
    private let getDayUseCase: GetDayUseCase
    private var defaultRange: Range<Int> {
        let currentYear = calendar.component(type(of: calendar).Component.year,
                                             from: currentDate)
        return Range((currentYear - 25)...(currentYear + 25))
    }

    private(set) var sections = [SectionCalendar]()
    private(set) var todaySection: SectionCalendar!
    private(set) var currentSection = IndexPath(row: 0, section: 0)

    init(currentDate: Date = Date(), calendar: Calendar = Calendar.current, getDayUseCase: GetDayUseCase) {
        self.getDayUseCase = getDayUseCase
        self.currentDate = currentDate
        self.calendar = calendar
        initInitialData()
    }

    private func initInitialData() {
        let currentDateData = DateData(date: currentDate, calendar: calendar)
        let section = SectionCalendar(dateData: currentDateData, getDayUseCase: getDayUseCase)
        todaySection = section
        sections.append(section)
        (0...6).forEach({ _ in
            loadPreviousMonth()
            loadNextMonth()
        })
    }

    func loadPreviousMonth() {
        guard let first = sections.first else { return }
        let dateComponents = first.dateData.previousMonth()
        let dateData = DateData(month: dateComponents.month, year: dateComponents.year)
        let sectionCalendar = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
        sections.insert(sectionCalendar, at: 0)
    }

    func loadNextMonth() {
        guard let last = sections.last else { return }
        let dateComponents = last.dateData.nextMonth()
        let dateData = DateData(month: dateComponents.month, year: dateComponents.year)
        let newSection = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
        sections.append(newSection)
    }
}
