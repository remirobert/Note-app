//
//  RMUpdatePostOperationSpec.swift
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

class RMUpdatePostOperationSpec: QuickSpec {
    private var configuration: Realm.Configuration!
    private var realmTest: Realm!
    private var operationQueue: OperationQueue!

    override func spec() {
        super.spec()

        describe("RMUpdatePostOperation tests") {
            beforeEach {
                self.configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: self.configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
                self.operationQueue = OperationQueue()
                self.operationQueue.maxConcurrentOperationCount = 1
            }
            it("should update an existant post") {
                let postFiles = ["1", "2", "3"]
                let rmPost = RMPost(date: Date(), id: "1234", images: postFiles, titlePost: "title", descriptionPost: "description", colorHexString: UIColor.red.toHexString())
                let rmDay = RMDay(id: "5678", date: Date(), numberPosts: 1)
                rmDay.posts.append(rmPost)

                let fileManager = StubFileManager()

                try! self.realmTest.write {
                    self.realmTest.add(rmPost)
                    self.realmTest.add(rmDay)
                }

                let updatedPost = Post(date: rmPost.date, id: "1234", images: [], titlePost: "title2", descriptionPost: "description2", color: UIColor.green)

                let updateOperation = RMUpdatePostOperation(post: updatedPost,
                                                            files: postFiles,
                                                            configuration: self.configuration,
                                                            fileManagerProvider: fileManager)
                updateOperation.imagesData = [Data(), Data()]
                self.operationQueue.addOperation(updateOperation)

                expect(updateOperation.isFinished).toEventually(beTrue())
                expect(self.realmTest.objects(RMPost.self).count).toEventually(be(1))
                expect(self.realmTest.objects(RMPost.self).first!.id).toEventually(equal(rmPost.id))
                expect(self.realmTest.objects(RMPost.self).first!.titlePost).toEventually(equal(updatedPost.titlePost))
                expect(self.realmTest.objects(RMPost.self).first!.descriptionPost).toEventually(equal(updatedPost.descriptionPost))
                expect(self.realmTest.objects(RMPost.self).first!.colorHexString).toEventually(equal(UIColor.green.toHexString()))
                expect(fileManager.filesAddedNames.count).toEventually(equal(2))
                expect(fileManager.filesRemovedNames.count).toEventually(equal(3))
            }
        }
    }
}
