//
//  DayFeedViewModel.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

protocol DayFeedViewModelDelegate: class {
    func didLoadPosts()
}

class DayFeedViewModel {
    fileprivate(set) var section = [Section]()
    fileprivate let postsOperationProvider: FetchOperationProvider
    fileprivate var postsOperation: FetchPostOperation?
    private let operationQueue: OperationQueue
    let day: Day

    weak var delegate: DayFeedViewModelDelegate?

    init(day: Day,
         postsOperationProvider: FetchOperationProvider,
         operationQueue: OperationQueue = OperationQueue()) {
        self.day = day
        self.postsOperationProvider = postsOperationProvider
        self.operationQueue = operationQueue
        self.operationQueue.qualityOfService = .background
        reloadSections()
    }

    func reloadSections() {
        print("🙏 reload sections")
        let operation = postsOperationProvider.makeFetchAll()
        postsOperation = operation
        postsOperation?.delegate = self
        operationQueue.cancelAllOperations()
        operationQueue.addOperation(operation)
    }
}

extension DayFeedViewModel: FetchPostOperationDelegate {
    func didFetchPosts(posts: [Post]) {
        print("🎃 get posts : \(posts)")
        let models = posts.map { (post: Post) -> CellViewModel? in
            if let image = post as? PostImage {
                return PostCellViewModel(post: image)
            }
            return nil
            }.flatMap { $0 }
        section = [Section(models: models, header: nil)]
        self.delegate?.didLoadPosts()
    }
}
