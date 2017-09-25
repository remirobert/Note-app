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

public class RMDataImage: Object {
    public dynamic var data = Data()

    public convenience init(data: Data) {
        self.init()
        self.data = data
    }
}

public class RMPostImage: RMPost {
    public var images = List<RMDataImage>()
    public dynamic var titlePost: String = ""
    public dynamic var descriptionPost: String = ""

    public convenience init(date: Date = Date(),
                            id: String = UUID().uuidString,
                            images: [Data],
                            titlePost: String = "",
                            descriptionPost: String = "") {
        self.init(date: date, id: id, type: .image)
        self.images = List(images.map({ return RMDataImage(data: $0) }))
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
        let imagesData = Array(self.images.map { return $0.data })
        return PostImage(date: self.date,
                         id: self.id,
                         images: imagesData,
                         titlePost: titlePost,
                         descriptionPost: descriptionPost)
    }
}
