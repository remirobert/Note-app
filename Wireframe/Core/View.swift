//
//  View.swift
//  Pods
//
//  Created by Remi Robert on 24/08/2017.
//
//

public protocol View: class {
    var navigationView: NavigationView? { get }
    func present(view: View, animated: Bool)
    func dismiss(animated: Bool)
}
