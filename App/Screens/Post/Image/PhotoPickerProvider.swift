//
//  PhotoProvider.swift
//  App
//
//  Created by Remi Robert on 10/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

typealias PhotoPickerCompletion = (UIImage?) -> Void

protocol PhotoPickerProvider {
    weak var delegate: PhotoPickerProviderDelegate? { get set }
    func pick(controller: UIViewController, completion: @escaping PhotoPickerCompletion)
    func pick(controller: UIViewController, delegate: PhotoPickerProviderDelegate)
}

protocol PhotoPickerProviderDelegate: class {
    func pickedPhoto(image: UIImage?)
}

class UIImagePicker: NSObject, UINavigationControllerDelegate, PhotoPickerProvider, UIImagePickerControllerDelegate {
    fileprivate let pickerController: UIImagePickerController
    fileprivate var rootViewController: UIViewController?
    fileprivate var completion: PhotoPickerCompletion?

    weak var delegate: PhotoPickerProviderDelegate?

    override init() {
        pickerController = UIImagePickerController()
        super.init()
    }

    func pick(controller: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        rootViewController = controller
        showSourceActionSheet()
    }

    func pick(controller: UIViewController, delegate: PhotoPickerProviderDelegate) {
        self.delegate = delegate
        rootViewController = controller
        showSourceActionSheet()
    }
}

extension UIImagePicker {
    fileprivate func showSourceActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { _ in
            self.pickerController.sourceType = .photoLibrary
            self.showPhotoPicker()
        }))
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { _ in
            if !UIImagePickerController.isCameraDeviceAvailable(.rear) {
                self.completion?(nil)
                return
            }
            self.pickerController.sourceType = .camera
            self.showPhotoPicker()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension UIImagePicker {
    fileprivate func showPhotoPicker() {
        pickerController.delegate = self
        rootViewController?.present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        delegate?.pickedPhoto(image: info[UIImagePickerControllerOriginalImage] as? UIImage)
        completion?(info[UIImagePickerControllerOriginalImage] as? UIImage)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        delegate?.pickedPhoto(image: nil)
        completion?(nil)
    }
}
