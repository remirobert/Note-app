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
        var rmPost: RMPost?

        switch post {
        case is PostText:
            rmPost = (post as? PostText)?.toRMPostText()
        case is PostImage:
            rmPost = (post as? PostImage)?.toRMPostImage()
        default: break
        }
        guard let rmPost2 = rmPost else { return }

        let anyPost = AnyPost(post: rmPost2)
        try? realm.write {
            realm.add(rmPost2)
            rmDay.posts.append(anyPost)
            realm.add(rmDay, update: true)
        }
    }
}
