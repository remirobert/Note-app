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

protocol PostCoordinatorDelegate: class {
    func didPostSuccess()
}

class PostCoordinator {
    private let day: Day
    private let parentView: View
    private let viewFactory: PostViewFactory
    private let navigationViewFactory: NavigationViewFactory
    fileprivate let postView: PostView

    weak var delegate: PostCoordinatorDelegate?

    init(day: Day, parentView: View) {
        self.day = day
        self.parentView = parentView
        viewFactory = PostImageViewControllerFactory(addPostUseCase: RMAddPostUseCase(day: day))
        navigationViewFactory = PostNavigationViewControllerFactory()
        postView = viewFactory.make()
    }

    func start() {
        postView.delegate = self
        let navigationView = navigationViewFactory.make(rootView: postView)
        parentView.present(view: navigationView)
    }
}

extension PostCoordinator: PostViewDelegate {
    func didCancel() {
        postView.dismiss()
    }

    func didPost() {
        postView.dismiss()
        delegate?.didPostSuccess()
    }
}
