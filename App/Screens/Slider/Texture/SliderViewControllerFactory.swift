//
//  SliderViewControllerFactory.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import UIKit
import Domain

class SliderViewControllerFactory: SliderViewFactory {
    let post: Post
    private let previewImage: UIImage?
    private let rectImage: CGRect
    private let startIndex: Int

    init(post: Post, previewImage: UIImage?, rectImage: CGRect, startIndex: Int) {
        self.post = post
        self.previewImage = previewImage
        self.rectImage = rectImage
        self.startIndex = startIndex
    }

    func make() -> SliderView {
        let viewModel = SliderViewModel(post: post)
        let previewTransition = SliderPreviewTransition(previewImage: previewImage,
                                                        previewRect: rectImage,
                                                        startIndex: startIndex)
        return SliderNodeController(viewModel: viewModel,
                                    previewTransition: previewTransition)
    }
}
