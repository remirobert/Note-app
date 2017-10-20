//
//  PostUpdateSubscriber.swift
//  RealmPlatform
//
//  Created by Remi Robert on 28/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Domain

public class PostUpdateSubscriber: PostSubscriber {
    private let configuration: Realm.Configuration
    private var subscribers = [PostUpdateSubscriberDelegate]()
    private var tokenNotification: NotificationToken?

    public init(configuration: Realm.Configuration = RMConfiguration.shared.configuration) {
        self.configuration = configuration
        getNotification()
    }

    public func addSubscriber(object: PostUpdateSubscriberDelegate) {
        subscribers.append(object)
    }

    public func removeSubscriber(object: PostUpdateSubscriberDelegate) {
    }

    private func getNotification() {
        guard let realm = try? Realm(configuration: configuration) else {
            return
        }
        tokenNotification = realm.addNotificationBlock { [weak self] notification, _ in
            switch notification {
            case .didChange:
                print("✅ post update: [\(self?.subscribers)]")
                self?.subscribers.forEach({
                    $0.dataDidUpdate()
                })
            default:
                break
            }
        }
    }

    private func stopNotification() {
        tokenNotification?.stop()
        tokenNotification = nil
    }
}
