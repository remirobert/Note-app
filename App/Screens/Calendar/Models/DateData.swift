//
//  Day.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

struct DateData {
    fileprivate let calendar: Calendar
    let dayModel: Day?
    let day: Int
    let month: Int
    let year: Int
    var isCurrentDay: Bool = false

    init(date: Date, calendar: Calendar = Calendar.current, dayModel: Day? = nil) {
        self.dayModel = dayModel
        self.calendar = calendar
        self.day = calendar.component(type(of: calendar).Component.day, from: date)
        self.month = calendar.component(type(of: calendar).Component.month, from: date) - 1
        self.year = calendar.component(type(of: calendar).Component.year, from: date)
    }

    init(day: Int = 0, month: Int, year: Int, calendar: Calendar = Calendar.current, dayModel: Day? = nil) {
        self.dayModel = dayModel
        self.calendar = calendar
        self.day = day
        self.month = month
        self.year = year
    }
}

extension DateData {
    func previousMonth() -> (month: Int, year: Int) {
        if month - 1 <= 0 {
            return (month: calendar.monthSymbols.count - 1, year: year - 1)
        }
        return (month: month - 1, year: year)
    }

    func nextMonth() -> (month: Int, year: Int) {
        if month + 1 >= calendar.monthSymbols.count {
            return (month: 0, year: year + 1)
        }
        return (month: month + 1, year: year)
    }
}

extension DateData: Equatable {
    static func ==(lhs: DateData, rhs: DateData) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
}

extension DateData {
    func toDate() -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month + 1
        components.year = year
        return calendar.date(from: components) ?? Date()
    }
}
