//
//  SplitView.swift
//  Wireframe
//
//  Created by Remi Robert on 14/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol SplitView: View {
    var master: View? { get set }
    var detail: View? { get set }
}
