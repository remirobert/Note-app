//
//  Date+daysCount.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension Date {
    static func daysCount(year: Int, month: Int, calendar: Calendar = Calendar.current) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) else {
                return 0
        }
        return range.count
    }
}
