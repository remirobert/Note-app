//
//  CalendarTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

class SectionCalendar {
    let month: Int
    let year: Int
    private(set) var days = [DateData]()
    var dateData: DateData {
        return DateData(day: 0, month: month, year: year)
    }

    init(month: Int, year: Int) {
        self.month = month
        self.year = year
        initDaysData()
    }

    init(dateData: DateData) {
        self.month = dateData.month
        self.year = dateData.year
        initDaysData()
    }

    private func initDaysData() {
        let dayCount = Date.daysCount(year: year, month: month + 1)
        days = (1...dayCount).map({ (day: Int) -> DateData in
            return DateData(day: day, month: month, year: year)
        })
    }
}

func ==(lhs: SectionCalendar, rhs: SectionCalendar) -> Bool {
    return lhs.month == rhs.month && lhs.year == rhs.year
}

class CalendarTextureViewModel {
    private let currentDate: Date
    private let calendar: Calendar
    private var defaultRange: Range<Int> {
        let currentYear = calendar.component(type(of: calendar).Component.year,
                                             from: currentDate)
        return Range((currentYear - 25)...(currentYear + 25))
    }

    private(set) var sections = [SectionCalendar]()
    private(set) var currentSection = IndexPath(row: 0, section: 0)

    init(currentDate: Date = Date(), calendar: Calendar = Calendar.current) {
        self.currentDate = currentDate
        self.calendar = calendar
        initInitialData()
    }

    private func initInitialData() {
        let currentDateData = DateData(date: currentDate, calendar: calendar)
        sections.append(SectionCalendar(dateData: currentDateData))
    }

    func loadPreviousMonth() {
        guard let first = sections.first else { return }
        let newSection = SectionCalendar(dateData: first.dateData.previousMonth())
        sections.insert(newSection, at: 0)
    }

    func loadNextMonth() {
        guard let last = sections.last else { return }
        let newSection = SectionCalendar(dateData: last.dateData.nextMonth())
        sections.append(newSection)
    }

//    func initSections(range: Range<Int>) {
//        let currentDateData = DateData(date: currentDate, calendar: calendar)
//        currentSection = IndexPath(row: 0, section: ((currentDateData.year - range.lowerBound) * 12) + currentDateData.month + 1)
//
//        for year in [Int](range.lowerBound..<range.upperBound) {
//            for month in 0..<calendar.monthSymbols.count {
//                let dayCount = Date.daysCount(year: year, month: month + 1, calendar: calendar)
//                let models = (1...dayCount).map({ (day: Int) -> DateData in
//                    return DateData(day: day, month: month, year: year, calendar: calendar)
//                })
//                let section = SectionCalendar(month: month, year: year, days: models)
//                sections.append(section)
//            }
//        }
//    }
}
