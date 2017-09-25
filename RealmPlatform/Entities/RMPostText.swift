//
//  RMContentText.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation
import RealmSwift
import Domain

public class RMPostText: RMPost {
    public dynamic var text: String = ""

    public convenience init(date: Date = Date(),
                     id: String = UUID().uuidString,
                     text: String) {
        self.init(date: date, id: id, type: .text)
        self.text = text
    }

    public override func name() -> String {
        return "RMPostText"
    }
}

extension PostText {
    public func toRMPostText() -> RMPostText {
        return RMPostText(date: self.date,
                          id: self.id,
                          text: self.text)
    }
}

extension RMPostText {
    public func toPostText() -> PostText {
        return PostText(date: self.date,
                        id: self.id,
                        text: self.text)
    }
}
