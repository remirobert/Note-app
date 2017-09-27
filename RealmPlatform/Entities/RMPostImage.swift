//
//  RMContentImage.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation
import RealmSwift
import Domain

public class RMPathImage: Object {
    public dynamic var url = String()

    public convenience init(url: String) {
        self.init()
        self.url = url
    }
}

public class RMPostImage: RMPost {
    public var images = List<RMPathImage>()
    public dynamic var titlePost = String()
    public dynamic var descriptionPost = String()

    public convenience init(date: Date = Date(),
                            id: String = UUID().uuidString,
                            images: [String],
                            titlePost: String = String(),
                            descriptionPost: String = String()) {
        self.init(date: date, id: id, type: .image)
        self.images = List(images.map({ return RMPathImage(url: $0) }))
        self.descriptionPost = descriptionPost
        self.titlePost = titlePost
    }
}

extension PostImage {
    public func toRMPostImage() -> RMPostImage {
        return RMPostImage(date: self.date,
                           id: self.id,
                           images: images,
                           titlePost: titlePost,
                           descriptionPost: descriptionPost)
    }
}

extension RMPostImage {
    public func toPostImage() -> PostImage {
        let imagesUrls = Array(self.images.map { return $0.url })
        return PostImage(date: self.date,
                         id: self.id,
                         images: imagesUrls,
                         titlePost: titlePost,
                         descriptionPost: descriptionPost)
    }
}
