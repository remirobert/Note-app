//
//  PostImageViewController.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class PostImageViewController: PostViewController {
    fileprivate let photoPickerProvider: PhotoPickerProvider
    fileprivate let viewModel: PostImageViewModel

    fileprivate let imageCell: GalleryCell
    fileprivate let titleCell = TextViewCell(textAttributes: TextAttributes.postCreationTitle)
    fileprivate let contentCell = TextViewCell(textAttributes: TextAttributes.postCreationContent)
    fileprivate let imageUploadCellViewModel = GalleryCellViewModel()

    init(photoPickerProvider: PhotoPickerProvider,
         viewModel: PostImageViewModel) {
        self.photoPickerProvider = photoPickerProvider
        self.viewModel = viewModel
        self.imageCell = GalleryCell(viewModel: imageUploadCellViewModel)
        super.init()
        self.cells = [self.titleCell, self.imageCell, self.contentCell]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCell.delegateUpload = self
        postKeyboardView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        contentCell.keyboardAccessoryView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        titleCell.keyboardAccessoryView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentCell.textView.becomeFirstResponder()
    }

    @objc private func addPost() {
        let images = imageUploadCellViewModel.images
        let title = titleCell.textView.text ?? ""
        let text = contentCell.textView.text ?? ""
        viewModel.create(images: images, titlePost: title, descriptionPost: text)
        DispatchQueue.main.async {
            self.delegate?.didPost()
        }
    }
}

extension PostImageViewController: ImageUploadCellDelegate {
    func addPhoto() {
        photoPickerProvider.pick(controller: self, delegate: imageUploadCellViewModel)
    }
}

