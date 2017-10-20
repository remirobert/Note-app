//
//  RMFetchPostOperationSpec.swift
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

class RMFetchPostOperationSpec: QuickSpec {
    private var configuration: Realm.Configuration!
    private var realmTest: Realm!
    private var operationQueue: OperationQueue!

    override func spec() {
        super.spec()

        describe("RMFetchPostOperation tests") {
            beforeEach {
                self.configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: self.configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
                self.operationQueue = OperationQueue()
                self.operationQueue.maxConcurrentOperationCount = 1
            }
            it("the operation should fetch the posts for the given day") {
                let rmDay = RMDay()
                let rmPost = RMPost(images: [],
                                    titlePost: "title",
                                    descriptionPost: "description",
                                    colorHexString: UIColor.blue.toHexString())
                rmDay.posts.append(rmPost)

                try! self.realmTest.write {
                    self.realmTest.add(rmPost)
                    self.realmTest.add(rmDay)
                }

                let fetchOperation = RMFetchPostOperation(day: rmDay.toDay(),
                                                          configuration: self.configuration)
                self.operationQueue.addOperation(fetchOperation)

                expect(fetchOperation.isFinished).toEventually(beTrue())
                expect(fetchOperation.posts.count).toEventually(equal(1))
                expect(fetchOperation.posts.first!.id).toEventually(equal(rmPost.id))
            }
            it("if the day does not exist, shoudl return empty array") {
                let rmDay = RMDay()
                let fetchOperation = RMFetchPostOperation(day: rmDay.toDay(),
                                                          configuration: self.configuration)
                self.operationQueue.addOperation(fetchOperation)

                expect(fetchOperation.isFinished).toEventually(beTrue())
                expect(fetchOperation.posts).toEventually(beEmpty())
            }
        }
    }
}
