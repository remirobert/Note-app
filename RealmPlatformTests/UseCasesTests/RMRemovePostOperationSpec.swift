//
//  RMRemovePostOperationSpec.swift
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

class RMRemovePostOperationSpec: QuickSpec {
    private var configuration: Realm.Configuration!
    private var realmTest: Realm!
    private var operationQueue: OperationQueue!

    override func spec() {
        super.spec()

        describe("RMRemovePostOperation tests") {
            beforeEach {
                self.configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: self.configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
                self.operationQueue = OperationQueue()
                self.operationQueue.maxConcurrentOperationCount = 1
            }
            it("the operation should remove a post") {
                let postImages = ["1", "2"]
                let rmDay = RMDay()
                let rmPost = RMPost(images: postImages,
                                    titlePost: "title",
                                    descriptionPost: "description",
                                    colorHexString: UIColor.blue.toHexString())
                rmDay.posts.append(rmPost)

                try! self.realmTest.write {
                    self.realmTest.add(rmPost)
                    self.realmTest.add(rmDay)
                }

                let fileManager = StubFileManager()
                let removeOperation = RMRemoveOperation(day: rmDay.toDay(),
                                                        post: rmPost.toPost(),
                                                        configuration: self.configuration,
                                                        fileManagerProvider: fileManager)
                self.operationQueue.addOperation(removeOperation)

                expect(removeOperation.isFinished).toEventually(beTrue())
                expect(self.realmTest.objects(RMPost.self)).toEventually(beEmpty())
                expect(fileManager.filesRemovedNames).toEventually(equal(postImages))
                expect(rmPost.isInvalidated).toEventually(beTrue())
            }
        }
    }
}
