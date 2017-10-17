//
//  SliderCoordinator.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain

class SliderCoordinator: NSObject {
    fileprivate let viewFactory: SliderViewFactory
    fileprivate let parentView: View
    fileprivate var sliderView: SliderView!

    init(post: Post, parentView: View, previewImage: UIImage?, rectImage: CGRect, startIndex: Int = 0) {
        viewFactory = SliderViewControllerFactory(post: post,
                                                  previewImage: previewImage,
                                                  rectImage: rectImage,
                                                  startIndex: startIndex)
        self.parentView = parentView
        super.init()
    }

    func start() {
        sliderView = viewFactory.make()
        sliderView.delegate = self
//        sliderView.viewController?.transitioningDelegate = parentView as! DayTextureFeedController
//        (sliderView.viewController as? SliderNodeController)?.ensureDisplay()
        let sliderNavigationController = SliderNavigationController(rootViewController: sliderView.viewController ?? UIViewController())
        sliderNavigationController.modalPresentationStyle = .formSheet
        parentView.present(view: sliderNavigationController, animated: true)
    }
}

extension SliderCoordinator: SliderViewDelegate {
    func dismiss() {
        sliderView.dismiss(animated: false)
    }
}
