//
//  RMAddPostOPerationSpec.swift
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

class RMAddPostOPerationSpec: QuickSpec {
    private var configuration: Realm.Configuration!
    private var realmTest: Realm!
    private var operationQueue: OperationQueue!
    
    override func spec() {
        super.spec()

        describe("RMAddPostOPeration tests") {
            beforeEach {
                self.configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: self.configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
                self.operationQueue = OperationQueue()
                self.operationQueue.maxConcurrentOperationCount = 1
            }
            it("the operation should add a new post") {
                let day = Day()
                let post = Post(titlePost: "title", descriptionPost: "description")
                let fileManager = StubFileManager()
                let addPostOperation = RMAddPostOperation(day: day,
                                                          configuration: self.configuration,
                                                          fileManagerProvider: fileManager)
                addPostOperation.post = post
                addPostOperation.imagesData = [Data(), Data()]

                self.operationQueue.addOperation(addPostOperation)

                expect(addPostOperation.isFinished).toEventually(beTrue())
                expect(self.realmTest.objects(RMPost.self).count).toEventually(be(1))
                expect(fileManager.filesAddedNames.count).toEventually(equal(2))
                expect(self.realmTest.objects(RMPost.self).first!.toPost().images).toEventually(equal(fileManager.filesAddedNames))
                expect(self.realmTest.objects(RMPost.self).first!.titlePost).toEventually(equal(post.titlePost))
                expect(self.realmTest.objects(RMPost.self).first!.descriptionPost).toEventually(equal(post.descriptionPost))
            }
        }
    }
}
