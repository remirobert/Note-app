//
//  RMRemoveOperation.swift
//  RealmPlatform
//
//  Created by Remi Robert on 17/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMRemoveOperation: RemovePostOperation {
    private let day: Day
    private let post: Post
    private let configuration: Realm.Configuration
    private let fileManagerProvider: FileManagerProvider

    public init(day: Day,
                post: Post,
                configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration,
                fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
        self.day = day
        self.post = post
        self.configuration = configuration
        self.fileManagerProvider = fileManagerProvider
    }

    override public func main() {
        if isCancelled {
            return
        }
        guard let realm = try? Realm(configuration: configuration) else {
            return
        }
        guard let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) else { return }
        guard let rmPost = realm.object(ofType: RMPost.self, forPrimaryKey: post.id) else { return }
        do {
            try realm.write {
                realm.delete(rmPost)
                rmDay.numberPosts -= 1
                realm.add(rmDay, update: true)
            }
            post.images.forEach {
                fileManagerProvider.removeFile(filename: $0)
            }
        } catch {
            print("⁉️ error delete post")
        }
    }
}
