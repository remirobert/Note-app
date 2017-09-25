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
        return Array(rmDay.posts).map { (anyPost: AnyPost) -> Post? in
            if let image = anyPost.value(configuration: self.configuration) as? RMPostImage {
                return image.toPostImage()
            }
            if let text = anyPost.value(configuration: self.configuration) as? RMPostText {
                return text.toPostText()
            }
            if let location = anyPost.value(configuration: self.configuration) as? RMPostLocation {
                return location.toPostLocation()
            }
            return nil
            }.flatMap { $0 }
    }
}
