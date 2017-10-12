//
//  SettingsView.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol SettingsViewDelegate: class {
    func dismiss()
}

protocol SettingsView: View {
    weak var delegate: SettingsViewDelegate? { get set }
}
