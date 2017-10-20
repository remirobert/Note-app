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
                configuration: Realm.Configuration = RMConfiguration.shared.configuration,
                fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
        self.day = day
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
        let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) ?? day.toRMDay()
        guard let rmPost = post?.toRMPost() else { return }
        let filesNames = imagesData.map {
            fileManagerProvider.saveFile(data: $0)
            }
            .flatMap {
                $0
            }
            .map {
                RMPathImage(url: $0)
        }
        rmPost.images = List<RMPathImage>(filesNames)
        save(object: rmPost, realm: realm, rmDay: rmDay)
    }

    private func save(object: RMPost, realm: Realm, rmDay: RMDay) {
        do {
            try realm.write {
                rmDay.numberPosts += 1
                realm.add(object)
                rmDay.posts.append(object)
                realm.add(rmDay, update: true)
                print("post: \(object)")
                print("day: \(rmDay)")
                print("✅ done creating post")
            }
        } catch {
            NSLog("❌ error : \(error.localizedDescription)")
        }
    }
}
