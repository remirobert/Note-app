//
//  SliderViewModel.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain

class SliderViewModel {
    let post: PostImage
    let images: [String]

    init(post: PostImage) {
        self.post = post
        self.images = post.images
    }
}
