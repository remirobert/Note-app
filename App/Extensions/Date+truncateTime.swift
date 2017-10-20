//
//  Date+truncateTime.swift
//  App
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension Date {
    func truncate(calendar: Calendar = Calendar.current) -> Date {
        let day = calendar.component(type(of: calendar).Component.day, from: self)
        let month = calendar.component(type(of: calendar).Component.month, from: self)
        let year = calendar.component(type(of: calendar).Component.year, from: self)
        return Date.fromComponents(day: day, month: month, year: year, calendar: calendar)
    }
}
