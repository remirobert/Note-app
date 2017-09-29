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
            return UIImageJPEGRepresentation($0, 1)
            }
            .flatMap {
                $0
        }
    }
}

class PostImageViewModel {
    private let addOperationProvider: AddOperationProvider
    private let operationQueue: OperationQueue

    init(addOperationProvider: AddOperationProvider,
         operationQueue: OperationQueue = OperationQueue()) {
        self.addOperationProvider = addOperationProvider
        self.operationQueue = operationQueue
        self.operationQueue.qualityOfService = .background
    }

    func create(images: [UIImage], titlePost: String, descriptionPost: String) {
        let convertOperation = ImageDataConvertOperation(images: images)
        let imagePost = PostImage(images: [],
                                  titlePost: titlePost,
                                  descriptionPost: descriptionPost)

        let addOperation = addOperationProvider.makeAdd()
        addOperation.post = imagePost

        let adapterOperation = BlockOperation() {
            [unowned convertOperation, unowned addOperation] in
            addOperation.imagesData = convertOperation.imagesData
        }

        adapterOperation.addDependency(convertOperation)
        addOperation.addDependency(adapterOperation)

        operationQueue.addOperations([convertOperation, adapterOperation, addOperation], waitUntilFinished: false)
    }
}
