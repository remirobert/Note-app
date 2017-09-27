//
//  RMAddPostOperation.swift
//  RealmPlatform
//
//  Created by Remi Robert on 26/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMAddPostOperation: AddPostOperation {
    private let day: Day
    private let configuration: Realm.Configuration
    private let fileManagerProvider: FileManagerProvider

    public init(day: Day,
                configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration,
                fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
        self.day = day
        self.configuration = configuration
        self.fileManagerProvider = fileManagerProvider
    }

    override public func main() {
        print("add operation")
        if isCancelled {
            print("canncelled")
            return
        }
        print("not canncelled")
        guard let realm = try? Realm(configuration: configuration) else {
            print("error realm")
            return
        }
        guard let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) else {
            print("rm day error")
            return
        }
        guard let rmPost = (post as? PostImage)?.toRMPostImage() else {
            print("post error")
            return
        }
        let filesNames = imagesData.map {
            fileManagerProvider.saveFile(data: $0)
            }
            .flatMap {
                $0
            }
            .map {
                RMPathImage(url: $0)
        }
        print("saved images : \(filesNames)")
        rmPost.images = List<RMPathImage>(filesNames)
        save(object: rmPost, realm: realm, rmDay: rmDay)
    }

    private func save(object: RMPost, realm: Realm, rmDay: RMDay) {
        let anyPost = AnyPost(post: object)
        try? realm.write {
            realm.add(object)
            rmDay.posts.append(anyPost)
            realm.add(rmDay, update: true)
        }
    }
}
