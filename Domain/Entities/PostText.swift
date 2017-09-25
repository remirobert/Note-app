//
//  ContentText.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation

public class PostText: Post {
    public let text: String

    public init(date: Date = Date(),
                id: String = UUID().uuidString,
                text: String) {
        self.text = text
        super.init(date: date, id: id, type: .text)
    }
}
