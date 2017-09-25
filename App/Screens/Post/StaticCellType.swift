//
//  StaticCell.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol StaticCellDelegate: class {
    func didUpdateContent()
}

protocol StaticCellType: class {
    var height: CGFloat { get }
    weak var delegate: StaticCellDelegate? { get set }
}
