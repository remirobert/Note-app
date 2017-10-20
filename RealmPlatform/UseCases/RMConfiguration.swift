//
//  RMConfiguration.swift
//  RealmPlatform
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift

public class RMConfiguration {
    public static let shared: RMConfiguration = RMConfiguration()
    private(set) var configuration = Realm.Configuration.defaultConfiguration
    
    public func login() {
        if let user = SyncUser.current {
            print(user.identity)
            self.configuration = Realm.Configuration(
                syncConfiguration: SyncConfiguration(user: user,
                                                     realmURL: URL(string: "realm://127.0.0.1:9080/~/realmtasks")!))
            return
        }
        let credential = SyncCredentials.usernamePassword(username: "remi", password: "remi", register: false)
        let urlServer = URL(string: "http://127.0.0.1:9080")!
        SyncUser.logIn(with: credential, server: urlServer) { user, error in
            print("user : \(user)")
            print("error: \(error?.localizedDescription)")
            self.configuration = Realm.Configuration(
                syncConfiguration: SyncConfiguration(user: user!,
                                                     realmURL: URL(string: "realm://127.0.0.1:9080/~/realmtasks")!)
            )
        }
    }
}
