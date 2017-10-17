//
//  ContentService.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol AllPostUseCase {
    func get() -> [Post]
}

public protocol FetchPostOperationDelegate: class {
    func didFetchPosts(posts: [Post])
}

open class FetchPostOperation: Operation {
    public var posts = [Post]()
    public weak var delegate: FetchPostOperationDelegate?
}

public protocol PostUpdateSubscriberDelegate: class {
    func dataDidUpdate()
}

public protocol PostSubscriber: class {
    func addSubscriber(object: PostUpdateSubscriberDelegate)
    func removeSubscriber(object: PostUpdateSubscriberDelegate)
}

open class RemovePostOperation: Operation {}
