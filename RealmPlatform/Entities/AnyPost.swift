//
//  AnyPost.swift
//  RealmPlatform
//
//  Created by Remi Robert on 28/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift

public class AnyPost: Object {
    dynamic var typeName: String = ""
    dynamic var primaryKey: String = ""

    private var supportedTypes: [String: RMPost.Type] {
        return [
            "RMPostText": RMPostText.self,
            "RMPostImage": RMPostImage.self,
            "RMPostLocation": RMPostLocation.self
        ]
    }

    convenience init(post: RMPost) {
        self.init()
        typeName = String(describing: type(of: post))
        print("save post: \(typeName)")
        print("name post: \(post.name())")
        if let text = post as? RMPostText {
            print("it's a text : \(text)")
        }
        guard let primaryKeyName = type(of: post).primaryKey() else {
            fatalError("`\(typeName)` does not define a primary key")
        }
        guard let primaryKeyValue = post.value(forKey: primaryKeyName) as? String else {
            fatalError("`\(typeName)`'s primary key `\(primaryKeyName)` is not a `String`")
        }
        primaryKey = primaryKeyValue
    }

    func value(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) -> RMPost {
        guard let realm = try? Realm(configuration: configuration),
            let type = supportedTypes[typeName],
            let value = realm.object(ofType: type, forPrimaryKey: primaryKey as AnyObject) else {
                fatalError("`\(typeName)` with primary key `\(primaryKey)` does not exist")
        }
        return value
    }
}
