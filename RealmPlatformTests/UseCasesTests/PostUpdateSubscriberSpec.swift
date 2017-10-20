//
//  PostUpdateSubscriberSpec.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import Quick
import Nimble
import RealmSwift
@testable import RealmPlatform

class PostUpdateSubscriberSpec: QuickSpec {
    private var realmTest: Realm!
    private var postUpdateSubscriber: PostUpdateSubscriber!

    override func spec() {
        super.spec()

        describe("PostUpdateSubscriber tests") {
            beforeEach {
                let configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
                self.postUpdateSubscriber = PostUpdateSubscriber(configuration: configuration)
            }
            it("should get the update when a object changed") {
                let rmDay = RMDay()
                let postUpdateSpy = PostUpdateSpy()
                self.postUpdateSubscriber.addSubscriber(object: postUpdateSpy)

                try! self.realmTest.write {
                    self.realmTest.add(rmDay)
                }
                expect(postUpdateSpy.dataUpdateCount) == 1
            }
        }
    }
}

internal class PostUpdateSpy: PostUpdateSubscriberDelegate {
    private(set) var dataUpdateCount = 0

    func dataDidUpdate() {
        dataUpdateCount += 1
    }
}
