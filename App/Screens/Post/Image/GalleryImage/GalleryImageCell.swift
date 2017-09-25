//
//  GalleryImageCell.swift
//  App
//
//  Created by Remi Robert on 20/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class GalleryImageCellViewModel: CellViewModel {
    let image: UIImage
    let reuseIdentifier = String(describing: GalleryImageCell.self)

    init(image: UIImage) {
        self.image = image
    }

    func contentSize() -> CGSize {
        return GalleryCollectionViewLayout.cellSize
    }
}

class GalleryImageCell: UICollectionViewCell, CellType {
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

    func bind(cellData: CellViewModel) {
        guard let imageModel = cellData as? GalleryImageCellViewModel else { return }
        imageView.image = imageModel.image
    }
}

extension GalleryImageCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(imageView)
    }

    fileprivate func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    fileprivate func setupViews() {
        imageView.contentMode = .scaleToFill
    }
}
