//
//  PostTextView.swift
//  App
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol PostViewDelegate: class {
    func didPost()
    func didCancel()
}

protocol PostViewFactory: class {
    func make() -> PostView
}

protocol PostView: View {
    weak var delegate: PostViewDelegate? { get set }
}
