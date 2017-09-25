//
//  AddPostUseCaseSpec.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import Quick
import Nimble
import RealmSwift
@testable import RealmPlatform

class AddPostUseCaseSpec: QuickSpec {
    private let day = Day()
    private var rmDay: RMDay!
    private var services: PostUseCaseProvider!
    private var addPostUseCase: AddPostUseCase!
    private var realmTest: Realm!

    override func spec() {
        super.spec()

        describe("Test Realm AddPostUseCase") {
            describe("when adding a new post") {
                beforeEach {
                    let configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                    self.services = RMPostUseCaseProvider(day: self.day, configuration: configuration)
                    self.addPostUseCase = self.services.makeAddPostUseCase()
                    self.realmTest = try! Realm(configuration: configuration)
                    self.rmDay = self.day.toRMDay()
                    try! self.realmTest.write {
                        self.realmTest.deleteAll()
                        self.realmTest.add(self.rmDay)
                    }
                }
                it("it should be stored on the realm database") {
                    let post = Post(type: PostType.image)
                    self.addPostUseCase.add(post: post)
                    let object = self.realmTest.object(ofType: RMPost.self, forPrimaryKey: post.id)!

                    expect(object.id) == post.id
                    expect(object.type) == post.type.rawValue
                    expect(self.rmDay.posts.count) == 1
                }
            }
        }
    }
}
