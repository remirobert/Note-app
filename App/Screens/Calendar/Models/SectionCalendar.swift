//
//  SectionCalendar.swift
//  App
//
//  Created by Remi Robert on 06/10/2017.
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

    func setCurrentDay(day: Int) {
        if days.count <= day {
            return
        }
        days[day].isCurrentDay = true
    }

    func unsetCurrentDay(day: Int) {
        if days.count <= day {
            return
        }
        days[day].isCurrentDay = false
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
