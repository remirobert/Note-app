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
    fileprivate var sliderView: SliderView!

    init(post: PostImage, parentView: View) {
        viewFactory = SliderViewControllerFactory(post: post)
        self.parentView = parentView
    }

    func start() {
        sliderView = viewFactory.make()
        sliderView.delegate = self
        parentView.present(view: sliderView)
    }
}

extension SliderCoordinator: SliderViewDelegate {
    func dismiss() {
        sliderView.dismiss()
    }
}
