//
//  PostImageViewModel.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Domain

class ImageDataConvertOperation: Operation {
    private(set) var imagesData = [Data]()
    private let images: [UIImage]

    init(images: [UIImage]) {
        self.images = images
    }

    override func main() {
        if isCancelled {
            return
        }
        imagesData = images.map {
            if isCancelled {
                return nil
            }
            return UIImageJPEGRepresentation($0, 0.1)
            }
            .flatMap {
                $0
        }
    }
}

class PostViewModel {
    private let addOperationProvider: AddOperationProvider
    private let operationQueue: OperationQueue
    let postUpdate: Post?

    init(postUpdate: Post? = nil,
         addOperationProvider: AddOperationProvider,
         operationQueue: OperationQueue = OperationQueue()) {
        self.postUpdate = postUpdate
        self.addOperationProvider = addOperationProvider
        self.operationQueue = operationQueue
        self.operationQueue.qualityOfService = .background
    }

    func create(images: [UIImage],
                titlePost: String,
                descriptionPost: String,
                color: UIColor) {
        let convertOperation = ImageDataConvertOperation(images: images)
        let post = Post(images: [],
                        titlePost: titlePost,
                        descriptionPost: descriptionPost,
                        color: color)

        let addOperation = addOperationProvider.makeAdd()
        addOperation.post = post

        let adapterOperation = BlockOperation() {
            [unowned convertOperation, unowned addOperation] in
            addOperation.imagesData = convertOperation.imagesData
        }

        adapterOperation.addDependency(convertOperation)
        addOperation.addDependency(adapterOperation)

        operationQueue.addOperations([convertOperation, adapterOperation, addOperation],
                                     waitUntilFinished: false)
    }

    func update(images: [UIImage],
                titlePost: String,
                descriptionPost: String,
                color: UIColor) {
        guard let post = postUpdate else { return }
        let convertOperation = ImageDataConvertOperation(images: images)
        let newPost = Post(date: post.date,
                           id: post.id,
                           images: [],
                           titlePost: titlePost,
                           descriptionPost: descriptionPost,
                           color: color)
        let updateOperation = addOperationProvider.makeUpdate(post: newPost, oldFiles: post.images)

        let adapterOperation = BlockOperation() {
            [unowned convertOperation, unowned updateOperation] in
            updateOperation.imagesData = convertOperation.imagesData
        }

        adapterOperation.addDependency(convertOperation)
        updateOperation.addDependency(adapterOperation)

        operationQueue.addOperations([convertOperation, adapterOperation, updateOperation],
                                     waitUntilFinished: false)
    }
}
