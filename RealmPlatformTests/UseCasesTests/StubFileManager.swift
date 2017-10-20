//
//  StubFileManager.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import RealmPlatform

class StubFileManager: FileManagerProvider {
    private(set) var filesAddedNames = [String]()
    private(set) var filesRemovedNames = [String]()

    func saveFile(data: Data) -> String? {
        let count = filesAddedNames.count + 1
        filesAddedNames.append("\(count)")
        return "\(count)"
    }

    func removeFile(filename: String) {
        let count = filesRemovedNames.count + 1
        filesRemovedNames.append("\(count)")
    }
}
