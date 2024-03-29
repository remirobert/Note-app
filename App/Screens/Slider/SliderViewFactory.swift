//
//  SliderViewFactory.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol SliderViewFactory: class {
    func make() -> SliderView
}
