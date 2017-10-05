
//
//  GetDayUseCase.swift
//  RealmPlatform
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import RealmSwift

public class RMGetDayUseCase: GetDayUseCase {
    private let configuration: Realm.Configuration

    public init(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.configuration = configuration
    }

    public func get(forDate date: Date) -> Day? {
        guard let realm = try? Realm(configuration: configuration) else {
            return nil
        }
        let predicate = NSPredicate(format: "date = %@", date as NSDate)
        guard let day = realm.objects(RMDay.self).filter(predicate).first else {
            return nil
        }
        print("✴️ : \(day)")
        return day.toDay()
    }

    public func createNewDay(date: Date) -> Day {
        guard let realm = try? Realm(configuration: configuration) else {
            return Day()
        }
        let day = RMDay(date: date)
        try? realm.write {
            realm.add(day)
        }
        return day.toDay()
    }
}
