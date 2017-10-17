//
//  DayTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

protocol DayTextureViewModelDelegate: class {
    func didLoadPosts()
}

class DayTextureViewModel {
    fileprivate(set) var models = [Post]()
    fileprivate let postsOperationProvider: FetchOperationProvider
    fileprivate var postsOperation: FetchPostOperation?
    fileprivate var removePostOperation: RemovePostOperation!
    fileprivate let subscriber: PostSubscriber
    private let operationQueue: OperationQueue
    let day: Day

    weak var delegate: DayTextureViewModelDelegate?

    init(day: Day,
         postsOperationProvider: FetchOperationProvider,
         operationQueue: OperationQueue = OperationQueue(),
         subscriber: PostSubscriber) {
        self.day = day
        self.postsOperationProvider = postsOperationProvider
        self.operationQueue = operationQueue
        self.operationQueue.qualityOfService = .background
        self.subscriber = subscriber
        self.subscriber.addSubscriber(object: self)
        reloadSections()
    }

    func reloadSections() {
        let operation = postsOperationProvider.makeFetchAll()
        postsOperation = operation
        postsOperation?.delegate = self
        operationQueue.cancelAllOperations()
        operationQueue.addOperation(operation)
    }

    func removePost(post: Post) {
        removePostOperation = postsOperationProvider.makeRemoveOperation(post: post)
        operationQueue.addOperation(removePostOperation)
    }
}

extension DayTextureViewModel: PostUpdateSubscriberDelegate {
    func dataDidUpdate() {
        reloadSections()
    }
}

extension DayTextureViewModel: FetchPostOperationDelegate {
    func didFetchPosts(posts: [Post]) {
        models = posts
        self.delegate?.didLoadPosts()
    }
}
