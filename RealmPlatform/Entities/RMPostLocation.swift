//
//  RMContentLocation.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation
import RealmSwift
import Domain

public class RMPostLocation: RMPost {
    public dynamic var latitude: Double = 0
    public dynamic var longitude: Double = 0

    public convenience init(date: Date = Date(),
                     id: String = UUID().uuidString,
                     latitude: Double,
                     longitude: Double) {
        self.init(date: date, id: id, type: .location)
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension PostLocation {
    public func toRMPostLocation() -> RMPostLocation {
        return RMPostLocation(date: self.date,
                              id: self.id,
                              latitude: self.latitude,
                              longitude: self.longitude)
    }
}

extension RMPostLocation {
    public func toPostLocation() -> PostLocation {
        return PostLocation(date: self.date,
                            id: self.id,
                            latitude: self.latitude,
                            longitude: self.longitude)
    }
}
