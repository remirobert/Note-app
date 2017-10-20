//
//  PostUpdateSubscriber.swift
//  Domain
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol PostUpdateSubscriberDelegate: class {
    func dataDidUpdate()
}

public protocol PostSubscriber: class {
    func addSubscriber(object: PostUpdateSubscriberDelegate)
    func removeSubscriber(object: PostUpdateSubscriberDelegate)
}
