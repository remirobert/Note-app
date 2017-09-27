//
//  PostUseCaseProvider.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol PostUseCaseProvider {
    func makeAllPostUseCase() -> AllPostUseCase
    func makeAddPostUseCase() -> AddPostUseCase
}

public protocol FetchOperationProvider {
    func makeFetchAll() -> FetchPostOperation
}
