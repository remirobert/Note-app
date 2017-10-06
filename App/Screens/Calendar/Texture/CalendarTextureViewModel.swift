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
    private let calendar: Calendar
    private let getDayUseCase: GetDayUseCase

    private(set) var sections = [SectionCalendar]()
    private(set) var todaySection: SectionCalendar!
    private(set) var currentSection: IndexPath?

    init(currentDate: Date = Date(), calendar: Calendar = Calendar.current, getDayUseCase: GetDayUseCase) {
        self.getDayUseCase = getDayUseCase
        self.currentDate = currentDate
        self.calendar = calendar
        self.currentDateData = DateData(date: currentDate, calendar: calendar)
        initInitialData()
    }

    private func initInitialData() {
        loadYear(year: currentDateData.year)
    }

    func loadYear(year: Int) {
        currentSection = nil
        calendar.monthSymbols.enumerated().forEach { index, _ in
            if currentDateData.month == index && currentDateData.year == year {
                currentSection = IndexPath(row: 0, section: index)
            }
            let dateData = DateData(month: index, year: year)
            let sectionCalendar = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
            sections.insert(sectionCalendar, at: 0)
        }
        sections.reverse()
    }
}
