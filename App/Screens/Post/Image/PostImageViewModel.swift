//
//  PostImageViewModel.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Domain

class PostImageViewModel {
    private let addPostUseCase: AddPostUseCase

    init(addPostUseCase: AddPostUseCase) {
        self.addPostUseCase = addPostUseCase
    }

    func create(images: [UIImage], titlePost: String, descriptionPost: String) {
        let imagesData = images.map { UIImagePNGRepresentation($0) ?? Data() }
        let imagePost = PostImage(images: imagesData,
                                  titlePost: titlePost,
                                  descriptionPost: descriptionPost)
        addPostUseCase.add(post: imagePost)
    }
}
