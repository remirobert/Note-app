//
//  CollectionVerticalLayout.swift
//  App
//
//  Created by Remi Robert on 16/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class VerticalCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setupLayout()
    }

    private func setupLayout() {
        scrollDirection = .vertical
        itemSize = CGSize.zero
        minimumInteritemSpacing = 0
        minimumLineSpacing = 20
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
