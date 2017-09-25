//
//  rmPostTextSpec.swift
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

class RMPostTextSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("rmPostText tests") {
            it("should create a rmPostText from a postText with the same data") {
                let date = Date()
                let text = "qwerty"
                let post = PostText(date: date, id: "123", text: text)
                let rmPost = post.toRMPostText()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
                expect(rmPost.text) == post.text
                expect(rmPost.type) == PostType.text.rawValue
            }
            it("should create a postText from a rmPostText with the same data") {
                let date = Date()
                let text = "qwerty"
                let rmPost = RMPostText(date: date, id: "123", text: text)
                let post = rmPost.toPostText()

                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.type) == post.type.rawValue
                expect(rmPost.text) == post.text
                expect(rmPost.type) == PostType.text.rawValue
            }
        }
    }
}
