//
//  PostImageViewControllerFactory.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Domain

class PostViewControllerFactory: PostViewFactory {
    private let photoPickerProvider: PhotoPickerProvider
    private let postViewModel: PostViewModel

    init(addOperationProvider: AddOperationProvider,
         photoPickerProvider: PhotoPickerProvider = UIImagePicker(),
        postUpdate: Post? = nil) {
        self.photoPickerProvider = photoPickerProvider
        self.postViewModel = PostViewModel(postUpdate: postUpdate,
                                           addOperationProvider: addOperationProvider)
    }

    func make() -> PostView {
        return PostViewController(photoPickerProvider: photoPickerProvider,
                                  viewModel: postViewModel)
    }
}
