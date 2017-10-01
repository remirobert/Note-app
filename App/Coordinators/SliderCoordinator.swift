//
//  SliderCoordinator.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain

class SliderCoordinator {
    fileprivate let viewFactory: SliderViewFactory
    fileprivate let parentView: View

    init(post: PostImage, parentView: View) {
        viewFactory = SliderViewControllerFactory(post: post)
        self.parentView = parentView
    }

    func start() {
        let sliderView = viewFactory.make()
        parentView.present(view: sliderView)
    }
}
