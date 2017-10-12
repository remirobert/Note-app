//
//  AuthentificationProvider.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol AuthentificationProviderDelegate: class {
    func authenticated(success: Bool)
}

protocol AuthentificationProvider {
    weak var delegate: AuthentificationProviderDelegate? { get set }
    var isAvailaible: Bool { get }
    func authentificate()
}

class LocalAuthentification: AuthentificationProvider {
    private let context = LAContext()
    weak var delegate: AuthentificationProviderDelegate?

    var isAvailaible: Bool {
        if #available(iOS 8.0, macOS 10.12.1, *) {
            return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        } else {
            return false
        }
    }

    func authentificate() {
        let myLocalizedReasonString = "Authentificate to access to the private content"
        var authError: NSError?

        if #available(iOS 8.0, macOS 10.12.1, *) {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    self.delegate?.authenticated(success: success)
                    return
                }
            }
        }
        delegate?.authenticated(success: false)
    }
}
