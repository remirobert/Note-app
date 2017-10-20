
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
    
    public init(configuration: Realm.Configuration = RMConfiguration.shared.configuration) {
        self.configuration = configuration
    }

    public func get(forDate date: Date) -> Day {
        guard let realm = try? Realm(configuration: configuration) else {
            return Day(date: date)
        }
        let predicate = NSPredicate(format: "date = %@", date as NSDate)
        guard let day = realm.objects(RMDay.self).filter(predicate).first else {
            return Day(date: date)
        }
        return day.toDay()
    }

    public func createNewDay(date: Date) -> Day {
        do {
            let _ = try Realm(configuration: configuration)
        } catch {
            NSLog("❌ error realm : \(error.localizedDescription)")
        }
        guard let realm = try? Realm(configuration: configuration) else {
            return Day()
        }
        let day = RMDay(date: date)
        do {
            try realm.write {
                realm.add(day)
            }
        } catch {
            NSLog("❌ error : \(error.localizedDescription)")
        }
        return day.toDay()
    }
}