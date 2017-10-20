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

public class RMFetchPostOperation: FetchPostOperation {
    private let day: Day
    private let configuration: Realm.Configuration

    public init(day: Day,
                configuration: Realm.Configuration = RMConfiguration.shared.configuration) {
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
        posts = Array(rmDay.posts).map({
            $0.toPost()
        })
        delegate?.didFetchPosts(posts: posts)
    }
}
