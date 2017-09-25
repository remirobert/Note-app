//
//  PostViewModel.swift
//  App
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Domain
import RealmPlatform

class PostViewModel {
    private let addPostUseCase: AddPostUseCase
    private let day: Day

    init(addPostUseCase: AddPostUseCase, day: Day) {
        self.addPostUseCase = addPostUseCase
        self.day = day
    }

    func createNewPost(content: String) {
        let post = PostText(text: content)
        addPostUseCase.add(post: post)
    }
}
