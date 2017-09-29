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
    private let addOperationProvider: AddOperationProvider
    private let photoPickerProvider: PhotoPickerProvider

    init(addOperationProvider: AddOperationProvider,
         photoPickerProvider: PhotoPickerProvider = UIImagePicker()) {
        self.addOperationProvider = addOperationProvider
        self.photoPickerProvider = photoPickerProvider
    }

    func make() -> PostView {
        let viewModel = PostImageViewModel(addOperationProvider: addOperationProvider)
        return PostImageViewController(photoPickerProvider: photoPickerProvider, viewModel: viewModel)
    }
}
