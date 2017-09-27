//
//  GalleryComponent.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit
import RealmPlatform

class GalleryViewComponentLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GalleryImageViewModel: CellViewModel {
    var reuseIdentifier = String(describing: ImageCell.self)
    private let height: CGFloat
    let imageUrl: String

    init(height: CGFloat, imageUrl: String) {
        self.imageUrl = imageUrl
        self.height = height
    }

    func contentSize() -> CGSize {
        return CGSize(width: height, height: height)
    }
}

class ImageCell: UICollectionViewCell, CellType {
    private let imageView = UIImageView(frame: CGRect.zero)
    let operationQueue = OperationQueue()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(cellData: CellViewModel) {
        guard let cellViewModel = cellData as? GalleryImageViewModel else { return }

        var path = DefaultFileManager.documentUrl
        path?.appendPathComponent(cellViewModel.imageUrl)
        guard let pathUrl = path else {
            return
        }

        operationQueue.addOperation { [weak self] in
            guard let image = UIImage(contentsOfFile: pathUrl.absoluteString) else { return }
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            image.draw(at: CGPoint.zero)
            let loadedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            OperationQueue.main.addOperation {
                self?.imageView.image = loadedImage
            }
        }
    }
}

class GalleryViewComponent: UICollectionView {
    private lazy var presenter = CollectionDataSource(collectionView: self)

    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: GalleryViewComponentLayout())
        register(cellType: ImageCell.self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(imagesUrl: [String]) {
        let height = heightCell(imagesCount: imagesUrl.count)
        let models = imagesUrl.map {
            return GalleryImageViewModel(height: height, imageUrl: $0)
        }
        presenter.sections = [Section(models: models)]
    }
}

extension GalleryViewComponent {
     fileprivate func heightCell(imagesCount: Int) -> CGFloat {
        var height: CGFloat = 0
        switch imagesCount {
        case 0:
            height = 0
        case 1:
            height = UIScreen.main.bounds.size.width
        case 2:
            height = UIScreen.main.bounds.size.width / 2
        default:
            height = UIScreen.main.bounds.size.width / 3
        }
        return height
    }

    static func heightComponent(imagesCount: Int) -> CGFloat {
        var height: CGFloat = 0
        switch imagesCount {
        case 1:
            height = UIScreen.main.bounds.size.width
        case 2:
            height = UIScreen.main.bounds.size.width / 2
        case 3:
            height = UIScreen.main.bounds.size.width / 3
        case 4..<6:
            height = UIScreen.main.bounds.size.width / 3 * 2
        case 7...9:
            height = UIScreen.main.bounds.size.width / 3 * 3
        default:
            break
        }
        return height
    }
}
