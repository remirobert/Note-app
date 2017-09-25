//
//  rmPostSpec.swift
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

class RMPostSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("rmPost tests") {
            it("should create a rmPost from a post with the same data") {
                let date = Date()
                let post = Post(date: date, id: "123", type: .image)
                let rmPost = post.toRMPost()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
            }
            it("should create a post from a rmPost with the same data") {
                let date = Date()
                let rmPost = RMPost(date: date, id: "123", type: .image)
                let post = rmPost.toPost()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
            }
        }
    }
}
