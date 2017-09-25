//
//  UICollectionView+register.swift
//  App
//
//  Created by Remi Robert on 16/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }

    private func register(supplementaryCellType: UICollectionReusableView.Type, kind: String) {
        register(supplementaryCellType,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: supplementaryCellType))
    }

    func registerHeader(supplementaryCellType: UICollectionReusableView.Type) {
        register(supplementaryCellType: supplementaryCellType, kind: UICollectionElementKindSectionHeader)
    }

    func registerFooter(supplementaryCellType: UICollectionReusableView.Type) {
        register(supplementaryCellType: supplementaryCellType, kind: UICollectionElementKindSectionFooter)
    }
}

