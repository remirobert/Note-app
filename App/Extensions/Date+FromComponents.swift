//
//  Date+FromComponents.swift
//  App
//
//  Created by Remi Robert on 05/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension Date {
    static func fromComponents(day: Int = 0,
                               month: Int,
                               year: Int,
                               calendar: Calendar = Calendar.current) -> Date {
        var components = DateComponents()
        components.calendar = calendar
        components.day = day
        components.month = month
        components.year = year
        components.hour = 12
        components.minute = 0
        components.second = 0
        let date = calendar.date(from: components) ?? Date()
        return date
    }
}
