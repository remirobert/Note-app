//
//  ImagePostCellTableViewCell.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
    static let cellSize: CGSize =  CGSize(width: (UIScreen.main.bounds.size.width - 20) / 4 - 10,
                                          height: (UIScreen.main.bounds.size.width - 20) / 4 - 10)

    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 10
        minimumInteritemSpacing = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ImageUploadCellDelegate: class {
    func addPhoto()
}

class GalleryCell: UITableViewCell, StaticCellType {
    fileprivate let collectionView: UICollectionView
    fileprivate let collectionViewPresenter: CollectionDataSource
    fileprivate(set) var height: CGFloat = GalleryCollectionViewLayout.cellSize.height
    fileprivate let viewModel: GalleryCellViewModel

    weak var delegate: StaticCellDelegate?
    weak var delegateUpload: ImageUploadCellDelegate?

    init(viewModel: GalleryCellViewModel) {
        self.viewModel = viewModel
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: GalleryCollectionViewLayout())
        collectionViewPresenter = CollectionDataSource(collectionView: collectionView)
        super.init(style: .default, reuseIdentifier: nil)
        self.viewModel.delegate = self
        setupViews()
        setupHierarchy()
        setupLayout()
        setupCollectionViewDatas()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCell: GalleryCellViewModelDelegate {
    func didUpdateModels() {
        collectionViewPresenter.sections = [Section(models: viewModel.models)]
        collectionView.sizeToFit()
        if viewModel.models.count <= 4 {
            height = GalleryCollectionViewLayout.cellSize.height + 10
        } else if viewModel.models.count >= 5 && viewModel.models.count <= 8 {
            height = (GalleryCollectionViewLayout.cellSize.height + 10) * 2
        } else {
            height = (GalleryCollectionViewLayout.cellSize.height + 10) * 3
        }
        delegate?.didUpdateContent()
    }
}

extension GalleryCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(collectionView)
    }

    fileprivate func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }

    fileprivate func setupViews() {
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(cellType: GalleryImageCell.self)
        collectionView.register(cellType: AddImageCell.self)
    }

    fileprivate func setupCollectionViewDatas() {
        collectionViewPresenter.sections = [Section(models: viewModel.models)]
        collectionViewPresenter.selectionHandler = { [weak self] _, viewModel in
            if viewModel is AddImageCellViewModel {
                self?.delegateUpload?.addPhoto()
            }
        }
        collectionView.reloadData()
    }
}
