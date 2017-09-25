//
//  PostTextViewControllerFactory.swift
//  App
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain

class PostTextViewControllerFactory: PostViewFactory {
    private let day: Day
    private let addPostUseCase: AddPostUseCase

    init(day: Day, addPostUseCase: AddPostUseCase) {
        self.day = day
        self.addPostUseCase = addPostUseCase
    }

    func make() -> PostView {
        let viewModel = PostViewModel(addPostUseCase: addPostUseCase, day: day)
        return PostTextViewController(viewModel: viewModel)
    }
}
