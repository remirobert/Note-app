//
//  AllPostUseCasesSpec.swift
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

class AllPostUseCasesSpec: QuickSpec {
    private var day: RMDay!
    private var services: PostUseCaseProvider!
    private var allPostUseCase: AllPostUseCase!
    private var realmTest: Realm!

    override func spec() {
        super.spec()

        describe("Tests Realm AllPostUseCases") {
            beforeEach {
                self.day = RMDay()
                self.services = RMPostUseCaseProvider(day: self.day.toDay())
                self.allPostUseCase = self.services.makeAllPostUseCase()
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
                self.realmTest = try! Realm()
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
            }
            it("if no posts saved, should return an empty array") {
                let posts = self.allPostUseCase.get()
                expect(posts.count) == 0
            }
            it("if a post is saved, should return it in an array") {
                let post1 = RMPostText(text: "test")
                let anyPost = AnyPost(post: post1)
                try! self.realmTest.write {
                    self.realmTest.add(post1)
                    self.day.posts.append(anyPost)
                    self.realmTest.add(self.day, update: true)
                }

                let posts = self.allPostUseCase.get()
                expect(posts.count) == 1
            }
        }
    }
}
