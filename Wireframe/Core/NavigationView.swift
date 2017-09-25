//
//  NavigationView.swift
//  Wireframe
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol NavigationViewFactory {
    func make(rootView: View) -> NavigationView
}

public protocol NavigationView: View {
    func push(view: View)
    func pop()
}
