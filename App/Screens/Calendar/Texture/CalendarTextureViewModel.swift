//
//  CalendarTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

class CalendarTextureViewModel {
    private let currentDate: Date
    let currentDateData: DateData
    private(set) var currentDisplayedYear: Int = 0
    private let calendar: Calendar
    private let getDayUseCase: GetDayUseCase

    private(set) var sections = [SectionCalendar]()
    private(set) var todaySection: SectionCalendar!
    private(set) var currentSection: IndexPath?
    private(set) var loadedSection: IndexPath?

    init(currentDate: Date = Date(), calendar: Calendar = Calendar.current, getDayUseCase: GetDayUseCase) {
        self.getDayUseCase = getDayUseCase
        self.currentDate = currentDate
        self.calendar = calendar
        self.currentDateData = DateData(date: currentDate, calendar: calendar)
        initInitialData()
    }

    private func initInitialData() {
        loadYear(fromDate: Date())
    }

    func loadYear(fromDate date: Date) {
        let year = calendar.component(Calendar.Component.year, from: date)
        let month = calendar.component(Calendar.Component.month, from: date)
        let day = calendar.component(Calendar.Component.day, from: date)
        currentDisplayedYear = year
        currentSection = nil
        loadedSection = nil
        sections.removeAll(keepingCapacity: true)
        calendar.monthSymbols.enumerated().forEach { index, _ in
            let dateData = DateData(month: index, year: year)
            let sectionCalendar = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
            if currentDateData.month == index && currentDateData.year == year {
                currentSection = IndexPath(row: 0, section: index)
                sectionCalendar.setCurrentDay(day: day)
            }
            if month == index {
                loadedSection = IndexPath(row: 0, section: index)
            }
            sections.insert(sectionCalendar, at: 0)
        }
        sections.reverse()
    }
}
