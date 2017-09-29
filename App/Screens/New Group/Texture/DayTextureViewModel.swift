//
//  DayTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

class DayTextureViewModel {
    fileprivate(set) var models = [PostImage]()
    fileprivate let postsOperationProvider: FetchOperationProvider
    fileprivate var postsOperation: FetchPostOperation?
    fileprivate let subscriber: PostSubscriber
    private let operationQueue: OperationQueue
    let day: Day

    weak var delegate: DayFeedViewModelDelegate?

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
}

extension DayTextureViewModel: PostUpdateSubscriberDelegate {
    func dataDidUpdate() {
        reloadSections()
    }
}

extension DayTextureViewModel: FetchPostOperationDelegate {
    func didFetchPosts(posts: [Post]) {
        print("🤜 post coiunt : \(posts.count)")
        print("🎃 get posts : \(posts)")
        models = (0...1000).map { _ in
            return PostImage(images: [], titlePost: "title", descriptionPost: "I seriously cannot study without this studio gibli music, it helps me concentrate a lot. I love this music, I wish I can thumbs up more than once.﻿")
        }
//        models = posts.map { (post: Post) -> PostImage? in
//            if let image = post as? PostImage {
//                return image
//            }
//            return nil
//            }.flatMap { $0 }
        self.delegate?.didLoadPosts()
    }
}

