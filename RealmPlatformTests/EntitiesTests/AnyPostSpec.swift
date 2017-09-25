//
//  AnyPostSpec.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 28/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Quick
import Nimble
import Domain
@testable import RealmPlatform

class AnyPostSpec: QuickSpec {
    private var realmTest: Realm!

    override func spec() {
        super.spec()

        describe("AnyPost abstraction tests") {
            beforeEach {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
                self.realmTest = try! Realm()
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
            }
            describe("") {
                it("") {
                    let postText = RMPostText(text: "abc")
                    let anyPost = AnyPost(post: postText)

                    let stubObject = StubObject()
                    stubObject.posts.append(anyPost)

                    try! self.realmTest.write {
                        self.realmTest.add(postText)
                        self.realmTest.add(stubObject)
                    }
                    let savedPost = stubObject.posts.first!.value() as! RMPostText

                    expect(savedPost.id) == postText.id
                    expect(savedPost.text) == postText.text
                }
                it("") {
                    let images = [Data(bytes: [1, 2, 3, 4, 5])]
                    let postImage = RMPostImage(images: images)
                    let anyPost = AnyPost(post: postImage)

                    let stubObject = StubObject()
                    stubObject.posts.append(anyPost)

                    try! self.realmTest.write {
                        self.realmTest.add(postImage)
                        self.realmTest.add(stubObject)
                    }
                    let savedPost = stubObject.posts.first!.value() as! RMPostImage

                    expect(savedPost.id) == postImage.id
                    expect(savedPost.images.first!.data) == images.first!
                }
                it("") {
                    let postLocation = RMPostLocation(latitude: 1, longitude: 2)
                    let anyPost = AnyPost(post: postLocation)

                    let stubObject = StubObject()
                    stubObject.posts.append(anyPost)

                    try! self.realmTest.write {
                        self.realmTest.add(postLocation)
                        self.realmTest.add(stubObject)
                    }
                    let savedPost = stubObject.posts.first!.value() as! RMPostLocation
                    
                    expect(savedPost.id) == postLocation.id
                    expect(savedPost.latitude) == postLocation.latitude
                    expect(savedPost.longitude) == postLocation.longitude
                }
            }
            describe("") {
                it("") {
                    let postText = RMPostText(text: "abc")
                    let postImage = RMPostImage(images: [Data()])
                    let postLocation = RMPostLocation(latitude: 1, longitude: 2)

                    let anyPost1 = AnyPost(post: postText)
                    let anyPost2 = AnyPost(post: postImage)
                    let anyPost3 = AnyPost(post: postLocation)

                    let stubObject = StubObject()
                    stubObject.posts.append(objectsIn: [anyPost1, anyPost2, anyPost3])

                    try! self.realmTest.write {
                        self.realmTest.add(postText)
                        self.realmTest.add(postImage)
                        self.realmTest.add(postLocation)
                        self.realmTest.add(stubObject)
                    }

                    expect(stubObject.posts[0].value() is RMPostText) == true
                    expect(stubObject.posts[1].value() is RMPostImage) == true
                    expect(stubObject.posts[2].value() is RMPostLocation) == true
                }
            }
        }
    }
}

internal class StubObject: Object {
    var posts = List<AnyPost>()
}
