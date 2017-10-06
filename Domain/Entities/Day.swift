//
//  Day.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation

public struct Day {
    public let date: Date
    public let id: String
    public let numberPosts: Int

    public init(id: String = UUID().uuidString,
                date: Date = Date(),
                numberPosts: Int = 0) {
        self.id = id
        self.date = date
        self.numberPosts = numberPosts
    }
}

extension Day: Equatable {
    static public func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.date == rhs.date &&
            lhs.id == rhs.id &&
            lhs.numberPosts == rhs.numberPosts
    }
}
