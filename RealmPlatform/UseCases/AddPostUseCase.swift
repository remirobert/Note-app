//
//  AddPostUseCase.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMAddPostUseCase: AddPostUseCase {
    private let day: Day
    private let configuration: Realm.Configuration

    public init(day: Day, configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.day = day
        self.configuration = configuration
    }

    public func add(post: Post) {
        guard let realm = try? Realm(configuration: configuration),
            let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) else {
            return
        }
    }

    public func addPostImage(images: [Data], title: String, description: String) {
    }

    private func save(object: RMPost, realm: Realm, rmDay: RMDay) {
        try? realm.write {
            realm.add(object)
            rmDay.posts.append(object)
            realm.add(rmDay, update: true)
        }
    }
}
