//
//  PostCoordinator.swift
//  App
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain
import RealmPlatform

class PostCoordinator {
    private let day: Day
    private let parentView: View
    private let viewFactory: PostViewFactory
    private let navigationViewFactory: NavigationViewFactory
    fileprivate let postView: PostView
    private let op: PostOperationFactory

    init(day: Day, parentView: View, postUpdate: Post? = nil) {
        self.day = day
        self.parentView = parentView
        op = RMPostOperationFactory(day: day)
        viewFactory = PostViewControllerFactory(addOperationProvider: op,
                                                postUpdate: postUpdate)
        navigationViewFactory = PostNavigationViewControllerFactory()
        postView = viewFactory.make()
    }

    func start() {
        postView.delegate = self
        let navigationView = navigationViewFactory.make(rootView: postView)
        navigationView.viewController?.modalPresentationStyle = .pageSheet
        parentView.present(view: navigationView, animated: true)
    }
}

extension PostCoordinator: PostViewDelegate {
    func didCancel() {
        postView.dismiss(animated: true)
    }

    func didPost() {
        postView.dismiss(animated: true)
    }
}
