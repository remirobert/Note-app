//
//  ContentImage.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation

public class PostImage: Post {
    public let images: [Data]
    public let titlePost: String
    public let descriptionPost: String

    public init(date: Date = Date(),
                id: String = UUID().uuidString,
                images: [Data],
                titlePost: String = "",
                descriptionPost: String = "") {
        self.images = images
        self.descriptionPost = descriptionPost
        self.titlePost = titlePost
        super.init(date: date, id: id, type: .image)
    }
}
