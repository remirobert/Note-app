//
//  rmPostLocationSpec.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Quick
import Nimble
import Domain
@testable import RealmPlatform

class RMPostLocationSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("rmPostLocation tests") {
            it("should create a rmPostLocation from a postLocation with the same data") {
                let date = Date()
                let latitude: Double = 1
                let longitude: Double = 2
                let post = PostLocation(date: date, id: "123", latitude: latitude, longitude: longitude)
                let rmPost = post.toRMPostLocation()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
                expect(rmPost.latitude) == post.latitude
                expect(rmPost.longitude) == post.longitude
                expect(rmPost.type) == PostType.location.rawValue
            }
            it("should create a postImage from a rmPostImage with the same data") {
                let date = Date()
                let latitude: Double = 1
                let longitude: Double = 2
                let rmPost = RMPostLocation(date: date, id: "123", latitude: latitude, longitude: longitude)
                let post = rmPost.toPostLocation()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
                expect(rmPost.latitude) == post.latitude
                expect(rmPost.longitude) == post.longitude
                expect(rmPost.type) == PostType.location.rawValue
            }
        }
    }
}
