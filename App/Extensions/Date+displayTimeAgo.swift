//
//  Date+displayTimeAgo.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension Date {
    func timeAgo(calendar: Calendar = .current) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full

        let now = Date()
        let units = Set<Calendar.Component>([.year, .month, .weekOfMonth, .day, .hour, .minute, .second])
        let components = calendar.dateComponents(units, from: self, to: now)

        if components.year ?? 0 > 0 {
            formatter.allowedUnits = .year
        } else if components.month ?? 0 > 0 {
            formatter.allowedUnits = .month
        } else if components.weekOfMonth ?? 0 > 0 {
            formatter.allowedUnits = .weekOfMonth
        } else if components.day ?? 0 > 0 {
            formatter.allowedUnits = .day
        } else if components.hour ?? 0 > 0 {
            formatter.allowedUnits = .hour
        } else if components.minute ?? 0 > 0 {
            formatter.allowedUnits = .minute
        } else {
            formatter.allowedUnits = .second
        }
        guard let timeAgoString = formatter.string(from: components) else {
            return ""
        }
        return "\(timeAgoString) ago"
    }
}
