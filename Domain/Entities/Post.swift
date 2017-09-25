//
//  Content.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

public enum PostType: Int {
    case image
    case text
    case location
}

public class Post {
    public let date: Date
    public let id: String
    public let type: PostType

    public init(date: Date = Date(),
                id: String = UUID().uuidString,
                type: PostType) {
        self.date = date
        self.id = id
        self.type = type
    }
}

extension Post: Equatable {
    static public func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id &&
            lhs.type == rhs.type
    }
}
