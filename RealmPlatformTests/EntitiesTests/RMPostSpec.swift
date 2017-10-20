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
import UIKit
@testable import RealmPlatform

class RMPostSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("RMPost tests") {
            it("should create a rmPost from a Post") {
                let date = Date()
                let post = Post(date: date, id: "1234", images: ["image"], titlePost: "title", descriptionPost: "description", color: UIColor.red)

                let rmPost = post.toRMPost()
                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.images.count) == 1
                expect(rmPost.titlePost) == post.titlePost
                expect(rmPost.descriptionPost) == post.descriptionPost
                expect(rmPost.colorHexString) == UIColor.red.toHexString()
            }
            it("should create a Post from a RMPost") {
                let date = Date()
                let rmPost = RMPost(date: date, id: "1234", images: ["image"], titlePost: "title", descriptionPost: "description", colorHexString: UIColor.red.toHexString())

                let post = rmPost.toPost()
                expect(rmPost.date) == post.date
                expect(rmPost.id) == post.id
                expect(rmPost.images.count) == 1
                expect(rmPost.titlePost) == post.titlePost
                expect(rmPost.descriptionPost) == post.descriptionPost
                expect(rmPost.colorHexString) == UIColor.red.toHexString()
            }
        }
    }
}
