//
//  ContentEquatableSpec.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Quick
import Nimble
@testable import Domain

class PostEquatableSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("Test Day Equatability model") {
            it("should return true if the posts are equal") {
                let post1 = Post(id: "123", type: PostType.image)
                let post2 = Post(id: "123", type: PostType.image)

                expect(post1) == post2
            }
            it("should return false if the ids are not equal") {
                let post1 = Post(id: "123", type: PostType.image)
                let post2 = Post(id: "321", type: PostType.image)

                expect(post1 == post2) == false
            }
            it("should return false if the types are not equal") {
                let post1 = Post(id: "123", type: PostType.image)
                let post2 = Post(id: "123", type: PostType.text)

                expect(post1 == post2) == false
            }
        }
    }
}
