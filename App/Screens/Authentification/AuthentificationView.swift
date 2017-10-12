//
//  AuthentificationView.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol AuthentificationViewDelegate: class {
    func authentificationSuccess()
}

protocol AuthentificationView: View {
    weak var delegate: AuthentificationViewDelegate? { get set }
}

protocol AuthentificationViewFactory {
    func make() -> AuthentificationView
}
