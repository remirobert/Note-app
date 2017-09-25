//
//  Date+.swift
//  App
//
//  Created by Remi Robert on 04/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

extension Date {
    static func from(string dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "fr")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
}
