//
//  RMUpdatePostOperation.swift
//  RealmPlatform
//
//  Created by Remi Robert on 18/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class RMUpdatePostOperation: UpdatePostOperation {
    private let post: Post
    private let files: [String]
    private let configuration: Realm.Configuration
    private let fileManagerProvider: FileManagerProvider

    public init(post: Post,
                files: [String],
                configuration: Realm.Configuration = RMConfiguration.shared.configuration,
                fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
        self.post = post
        self.files = files
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
        guard let rmPost = realm.object(ofType: RMPost.self, forPrimaryKey: post.id) else {
            return
        }
        removeFiles()
        let filesNames = saveFiles()
        do {
            try realm.write {
                realm.delete(rmPost.images)
                rmPost.titlePost = post.titlePost
                rmPost.descriptionPost = post.descriptionPost
                rmPost.colorHexString = post.color.toHexString()
                let images = List<RMPathImage>(filesNames)
                images.forEach({
                    realm.add($0)
                })
                rmPost.images.append(objectsIn: images)
            }
        } catch {
            NSLog("❌ error : \(error.localizedDescription)")
        }
    }

    private func removeFiles() {
        files.forEach {
            fileManagerProvider.removeFile(filename: $0)
        }
    }

    private func saveFiles() -> [RMPathImage] {
        return imagesData.map {
            fileManagerProvider.saveFile(data: $0)
            }
            .flatMap {
                $0
            }
            .map {
                RMPathImage(url: $0)
        }
    }
}
