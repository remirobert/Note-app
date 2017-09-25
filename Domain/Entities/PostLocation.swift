//
//  ContentLocation.swift
//  Pods
//
//  Created by Remi Robert on 27/08/2017.
//
//

import Foundation

public class PostLocation: Post {
    public let latitude: Double
    public let longitude: Double

    public init(date: Date = Date(),
                id: String = UUID().uuidString,
                latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init(date: date, id: id, type: .location)
    }
}
