//
//  CalendarViewModel.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CalendarViewModel {
    private let currentDate: Date
    private let calendar: Calendar
    private var defaultRange: Range<Int> {
        let currentYear = calendar.component(type(of: calendar).Component.year,
                                             from: currentDate)
        return Range((currentYear - 25)...(currentYear + 25))
    }

    private(set) var sections = [Section]()
    private(set) var currentSection = IndexPath(row: 0, section: 0)

    init(currentDate: Date = Date(), calendar: Calendar = Calendar.current) {
        self.currentDate = currentDate
        self.calendar = calendar
        initSections(range: defaultRange)
    }

    func initSections(range: Range<Int>) {
        let currentDateData = DateData(date: currentDate, calendar: calendar)
        currentSection = IndexPath(row: 0, section: ((currentDateData.year - range.lowerBound) * 12) + currentDateData.month + 1)

        for year in [Int](range.lowerBound..<range.upperBound) {
            for month in 0..<calendar.monthSymbols.count {
                let dayCount = Date.daysCount(year: year, month: month + 1, calendar: calendar)
                let models = (1...dayCount).map({ (day: Int) -> DayCellViewModel in
                    let dateData = DateData(day: day, month: month, year: year, calendar: calendar)
                    return DayCellViewModel(dateData: dateData, isCurrent: dateData == currentDateData)
                })
                let dateData = DateData(day: 0, month: month, year: year, calendar: calendar)
                let monthHeaderViewModel = HeaderMonthViewModel(dateData: dateData)
                let section = Section(models: models, header: monthHeaderViewModel)
                sections.append(section)
            }
        }
    }
}
