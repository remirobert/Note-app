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
    private let addPostUseCase: AddPostUseCase
    private let photoPickerProvider: PhotoPickerProvider

    init(addPostUseCase: AddPostUseCase,
         photoPickerProvider: PhotoPickerProvider = UIImagePicker()) {
        self.addPostUseCase = addPostUseCase
        self.photoPickerProvider = photoPickerProvider
    }

    func make() -> PostView {
        let viewModel = PostImageViewModel(addPostUseCase: addPostUseCase)
        return PostImageViewController(photoPickerProvider: photoPickerProvider, viewModel: viewModel)
    }
}
