//
//  PostUseCaseProvider.swift
//  App
//
//  Created by Remi Robert on 27/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import RealmSwift

public class RMPostUseCaseProvider: PostUseCaseProvider {
    private let day: Day
    private let configuration: Realm.Configuration

    public init(day: Day, configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.day = day
        self.configuration = configuration
    }

    public func makeAddPostUseCase() -> AddPostUseCase {
        return RMAddPostUseCase(day: day, configuration: configuration)
    }

    public func makeAllPostUseCase() -> AllPostUseCase {
        return RMAllPostUseCase(day: day, configuration: configuration)
    }
}
