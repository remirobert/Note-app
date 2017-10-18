//
//  PostContentUseCase.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol AddPostUseCase {
    func add(post: Post)
    func addPostImage(images: [Data], title: String, description: String)
}

open class AddPostOperation: Operation {
    public var imagesData = [Data]()
    public var post: Post?
}

open class UpdatePostOperation: Operation {
    public var imagesData = [Data]()
}

public protocol AddPostOperationFactory {
    func make() -> AddPostOperation
}
