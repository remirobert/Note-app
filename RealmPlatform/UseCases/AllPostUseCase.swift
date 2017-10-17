//
//  AllPostUseCase.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMAllPostUseCase: AllPostUseCase {
    private let day: Day
    private let configuration: Realm.Configuration

    public init(day: Day, configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.day = day
        self.configuration = configuration
    }

    public func get() -> [Post] {
        guard let realm = try? Realm(configuration: configuration),
            let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) else {
                return []
        }
        return Array(rmDay.posts).map({
            $0.toPost()
        })
    }
}
