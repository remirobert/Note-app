//
//  AddImageCell.swift
//  App
//
//  Created by Remi Robert on 20/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class AddImageCellViewModel: CellViewModel {
    let reuseIdentifier = String(describing: AddImageCell.self)

    func contentSize() -> CGSize {
        return GalleryCollectionViewLayout.cellSize
    }
}

class AddImageCell: UICollectionViewCell, CellType {
    fileprivate let imageView = UIImageView(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(cellData: CellViewModel) {}
}

extension AddImageCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(imageView)
    }

    fileprivate func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.center.equalToSuperview()
        }
    }

    fileprivate func setupViews() {
        contentView.backgroundColor = UIColor.black
        imageView.image = #imageLiteral(resourceName: "camera-selected")
    }
}
