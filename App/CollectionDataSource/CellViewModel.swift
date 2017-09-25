//
//  CellViewModel.swift
//  App
//
//  Created by Remi Robert on 16/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol CellViewModel: class {
    func contentSize() -> CGSize
    var reuseIdentifier: String { get }
}
