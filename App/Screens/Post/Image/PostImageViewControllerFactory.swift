//
//  PostImageViewControllerFactory.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Domain

class PostImageViewControllerFactory: PostViewFactory {
    private let addPostOperation: AddPostOperation
    private let photoPickerProvider: PhotoPickerProvider

    init(addPostOperation: AddPostOperation,
         photoPickerProvider: PhotoPickerProvider = UIImagePicker()) {
        self.addPostOperation = addPostOperation
        self.photoPickerProvider = photoPickerProvider
    }

    func make() -> PostView {
        let viewModel = PostImageViewModel(addOperation: addPostOperation)
        return PostImageViewController(photoPickerProvider: photoPickerProvider, viewModel: viewModel)
    }
}
