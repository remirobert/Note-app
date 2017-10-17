//
//  Content.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

public class Post {
    public let date: Date
    public let id: String
    public let images: [String]
    public let titlePost: String
    public let descriptionPost: String

    public init(date: Date = Date(),
                id: String = UUID().uuidString,
                images: [String] = [],
                titlePost: String = "",
                descriptionPost: String = "") {
        self.date = date
        self.id = id
        self.images = images
        self.titlePost = titlePost
        self.descriptionPost = descriptionPost
    }
}

extension Post: Equatable {
    static public func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id &&
            lhs.date == rhs.date &&
            lhs.titlePost == rhs.titlePost &&
            lhs.descriptionPost == rhs.descriptionPost
    }
}
