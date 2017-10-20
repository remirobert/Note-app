//
//  PostContentUseCase.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

open class AddPostOperation: Operation {
    public var imagesData = [Data]()
    public var post: Post?
}

open class UpdatePostOperation: Operation {
    public var imagesData = [Data]()
}

public protocol PostOperationFactory {
    func makeAdd() -> AddPostOperation
    func makeUpdate(post: Post, oldFiles: [String]) -> UpdatePostOperation
}
