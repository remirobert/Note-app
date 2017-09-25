//
//  ImageUploadCellViewModel.swift
//  App
//
//  Created by Remi Robert on 20/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

protocol GalleryCellViewModelDelegate: class {
    func didUpdateModels()
}

class GalleryCellViewModel {
    fileprivate(set) var models = [CellViewModel]()
    weak var delegate: GalleryCellViewModelDelegate?

    var images: [UIImage] {
        return models.map {
            ($0 as? GalleryImageCellViewModel)?.image
            }.flatMap { $0 }
    }

    init() {
        models = [AddImageCellViewModel()]
    }

    fileprivate func addPhoto(image: UIImage) {
        let newModel = GalleryImageCellViewModel(image: image)
        let insertPosition = models.count <= 1 ? 0 : models.count - 1
        models.insert(newModel, at: insertPosition)
        if models.count == 10 {
            models.removeLast()
        }
        delegate?.didUpdateModels()
    }
}

extension GalleryCellViewModel: PhotoPickerProviderDelegate {
    func pickedPhoto(image: UIImage?) {
        guard let image = image else { return }
        addPhoto(image: image)
    }
}
