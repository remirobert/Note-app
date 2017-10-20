//
//  FileManagerProvider.swift
//  RealmPlatform
//
//  Created by Remi Robert on 26/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

public protocol FileManagerProvider {
    func saveFile(data: Data) -> String?
    func removeFile(filename: String)
}

public class DefaultFileManager: FileManagerProvider {
    public static var documentUrl: URL? {
        let searchPath = FileManager.SearchPathDirectory.documentDirectory
        let domainMask = FileManager.SearchPathDomainMask.userDomainMask
        guard let path = NSSearchPathForDirectoriesInDomains(searchPath, domainMask, true).first else {
            return nil
        }
        return URL(string: path)
    }
    private let fileManager: FileManager

    public init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    public func saveFile(data: Data) -> String? {
        guard let documentUrl = DefaultFileManager.documentUrl else { return nil }
        let filename = UUID().uuidString
        let filepath = documentUrl.appendingPathComponent(filename)
        let success = fileManager.createFile(atPath: filepath.absoluteString, contents: data, attributes: nil)
        return success ? filename : nil
    }

    public func removeFile(filename: String) {
        guard let documentUrl = DefaultFileManager.documentUrl else { return }
        let filepath = documentUrl.appendingPathComponent(filename)
        do {
            try fileManager.removeItem(at: filepath)
        } catch {
            print("⁉️ error remove file : \(error.localizedDescription)")
        }
    }
}
