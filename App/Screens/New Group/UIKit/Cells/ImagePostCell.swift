//
//  ImagePostCell.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ImagePostCellViewModel: CellViewModel {
    let reuseIdentifier: String = String(describing: ImagePostCell.self)
    let imageData: Data

    func contentSize() -> CGSize {
        let size = UIScreen.main.bounds.size.width / 3
        return CGSize(width: size, height: size)
    }

    init(imageData: Data) {
        self.imageData = imageData
    }
}

class ImagePostCell: UICollectionViewCell, CellType {
    fileprivate let imageView = UIImageView()
    private let operationQueue = OperationQueue()

    override init(frame: CGRect) {
        super.init(frame: frame)
        operationQueue.qualityOfService = .background
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    func bind(cellData: CellViewModel) {
        guard let cellData = cellData as? ImagePostCellViewModel else { return }
        operationQueue.addOperation { [weak self] in
            guard let image = UIImage(data: cellData.imageData) else { return }
            let loadedImage = image.forceLoad()
            OperationQueue.main.addOperation {
                self?.imageView.image = loadedImage
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagePostCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(imageView)
    }

    fileprivate func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }

    fileprivate func setupViews() {
        contentView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shouldRasterize = true
        imageView.layer.masksToBounds = true
        imageView.layer.drawsAsynchronously = true
    }
}
