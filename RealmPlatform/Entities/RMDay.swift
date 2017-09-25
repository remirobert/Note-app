//
//  RMDay.swift
//  RealmPlatform
//
//  Created by Remi Robert on 28/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMDay: Object {
    public dynamic var date: Date = Date()
    public dynamic var id: String = UUID().uuidString
    public var posts = List<AnyPost>()

    public convenience init(id: String = UUID().uuidString,
                            date: Date = Date()) {
        self.init()
        self.date = date
        self.id = id
    }

    public override class func primaryKey() -> String? {
        return "id"
    }
}

extension Day {
    public func toRMDay() -> RMDay {
        return RMDay(id: self.id,
                     date: self.date)
    }
}

extension RMDay {
    public func toDay() -> Day {
        return Day(id: self.id,
                   date: self.date)
    }
}
