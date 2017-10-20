//
//  RMPostOperationFactory.swift
//  RealmPlatform
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain

public class RMPostOperationFactory: PostOperationFactory {
    private let day: Day
    private let fileManagerProvider: FileManagerProvider
    
    public init(day: Day,
                fileManagerProvider: FileManagerProvider = DefaultFileManager()) {
        self.day = day
        self.fileManagerProvider = fileManagerProvider
    }
    
    public func makeAdd() -> AddPostOperation {
        return RMAddPostOperation(day: day, fileManagerProvider: fileManagerProvider)
    }
    
    public func makeUpdate(post: Post, oldFiles: [String]) -> UpdatePostOperation {
        return RMUpdatePostOperation(post: post, files: oldFiles)
    }
    
    public func makeRemove(post: Post) -> RemovePostOperation {
        return RMRemoveOperation(day: day, post: post)
    }
    
    public func makeFetch() -> FetchPostOperation {
        return RMFetchPostOperation(day: day)
    }
}
