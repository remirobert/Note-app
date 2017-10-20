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

public class RMPathImage: Object {
    public dynamic var url = String()

    public convenience init(url: String) {
        self.init()
        self.url = url
    }
}

public class RMPost: Object {
    public dynamic var date: Date = Date()
    public dynamic var id: String = UUID().uuidString
    public var images = List<RMPathImage>()
    public dynamic var titlePost = String()
    public dynamic var descriptionPost = String()
    public dynamic var colorHexString = String()

    public func name() -> String {
        return "RMPost"
    }

    public convenience init(date: Date = Date(),
                            id: String = UUID().uuidString,
                            images: [String],
                            titlePost: String = String(),
                            descriptionPost: String = String(),
                            colorHexString: String) {
        self.init()
        self.date = date
        self.id = id
        self.images = List(images.map({ return RMPathImage(url: $0) }))
        self.descriptionPost = descriptionPost
        self.titlePost = titlePost
        self.colorHexString = colorHexString
    }

    public override class func primaryKey() -> String? {
        return "id"
    }
}

extension Post {
    public func toRMPost() -> RMPost {
        print("🖌 color : \(color) -> \(color.toHexString())")
        return RMPost(date: self.date,
                      id: self.id,
                      images: self.images,
                      titlePost: self.titlePost,
                      descriptionPost: self.descriptionPost,
                      colorHexString: self.color.toHexString())
    }
}

extension RMPost {
    public func toPost() -> Post {
        let imagesUrls = Array(self.images.map { return $0.url })
        let color = UIColor(hexString: colorHexString)
        return Post(date: self.date,
                    id: self.id,
                    images: imagesUrls,
                    titlePost: self.titlePost,
                    descriptionPost: self.descriptionPost,
                    color: color)
    }
}
