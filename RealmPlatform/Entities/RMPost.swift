//
//  RMContent.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation
import RealmSwift
import Domain

public class RMPost: Object {
    public dynamic var date: Date = Date()
    public dynamic var id: String = UUID().uuidString
    public var type: Int = 0

    public func name() -> String {
        return "RMPost"
    }

    public convenience init(date: Date = Date(),
                            id: String = UUID().uuidString,
                            type: PostType) {
        self.init()
        self.date = date
        self.id = id
        self.type = type.rawValue
    }

    public override class func primaryKey() -> String? {
        return "id"
    }
}

extension Post {
    public func toRMPost() -> RMPost {
        return RMPost(date: self.date,
                      id: self.id,
                      type: self.type)
    }
}

extension RMPost {
    public func toPost() -> Post {
        return Post(date: self.date,
                    id: self.id,
                    type: PostType(rawValue: self.type) ?? .text)
    }
}
