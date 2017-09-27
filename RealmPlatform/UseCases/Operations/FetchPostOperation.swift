//
//  FetchPostOperation.swift
//  RealmPlatform
//
//  Created by Remi Robert on 26/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

public class RMFetchPostOperationFactory: FetchOperationProvider {
    private let day: Day

    public init(day: Day) {
        self.day = day
    }

    public func makeFetchAll() -> FetchPostOperation {
        return RMFetchPostOperation(day: day)
    }
}

public class RMFetchPostOperation: FetchPostOperation {
    private let day: Day
    private let configuration: Realm.Configuration

    public init(day: Day,
                configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.day = day
        self.configuration = configuration
    }

    override public func main() {
        if isCancelled {
            return
        }
        guard let realm = try? Realm(configuration: configuration),
            let rmDay = realm.object(ofType: RMDay.self, forPrimaryKey: day.id) else {
                return
        }
        posts = Array(rmDay.posts).map { (anyPost: AnyPost) -> Post? in
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
        delegate?.didFetchPosts(posts: posts)
    }
}
