//
//  PhotoProvider.swift
//  App
//
//  Created by Remi Robert on 10/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController

typealias PhotoPickerCompletion = ([UIImage]?) -> Void

protocol PhotoPickerProvider {
    weak var delegate: PhotoPickerProviderDelegate? { get set }
    func pick(controller: UIViewController, completion: @escaping PhotoPickerCompletion)
    func pick(controller: UIViewController, delegate: PhotoPickerProviderDelegate)
}

protocol PhotoPickerProviderDelegate: class {
    func pickedPhoto(images: [UIImage]?)
}

class UIImagePicker: PhotoPickerProvider {
    fileprivate let pickerController = DKImagePickerController()
    fileprivate var completion: PhotoPickerCompletion?

    weak var delegate: PhotoPickerProviderDelegate?

    func pick(controller: UIViewController, completion: @escaping PhotoPickerCompletion) {
        self.completion = completion
        controller.present(pickerController, animated: true, completion: nil)
    }

    func pick(controller: UIViewController, delegate: PhotoPickerProviderDelegate) {
        self.delegate = delegate
        controller.present(pickerController, animated: true, completion: nil)
        pickerController.maxSelectableCount = 6
        pickerController.assetType = .allPhotos
        pickerController.sourceType = .photo

        let options = PHImageRequestOptions()
        options.resizeMode = .exact

        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            var images = [UIImage]()
            assets.forEach({ asset in
                asset.fetchOriginalImage(true, completeBlock: { image, _ in
                    if let image = image {
                        images.append(image)
                    }
                })
            })
            self.delegate?.pickedPhoto(images: images)
        }
    }
}
