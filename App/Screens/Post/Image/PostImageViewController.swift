//
//  PostImageViewController.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class EditTextNode: ASCellNode {
    let editNode = ASEditableTextNode()

    override init() {
        super.init()
        addSubnode(editNode)
        selectionStyle = .none
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return ASInsetLayoutSpec(insets: insets, child: editNode)
    }
}

class PostImageViewController: ASViewController<ASTableNode>, ASTableDataSource, PostView, ASEditableTextNodeDelegate {
    private let tableNode = ASTableNode()
    private let titleNode = EditTextNode()
    private let contentNode = EditTextNode()
    private let nodes: [ASCellNode]

    weak var delegate: PostViewDelegate?

    init(photoPickerProvider: PhotoPickerProvider,
         viewModel: PostImageViewModel) {
        nodes = [titleNode, contentNode]
        super.init(node: tableNode)
        tableNode.dataSource = self
        titleNode.editNode.delegate = self
        contentNode.editNode.delegate = self

        titleNode.editNode.attributedPlaceholderText = NSAttributedString(string: "Title here", attributes: TextAttributes.postCreationTitlePlaceholder)
        titleNode.editNode.typingAttributes = TextAttributes.postCreationTitle

        contentNode.editNode.attributedPlaceholderText = NSAttributedString(string: "What's on your mind...", attributes: TextAttributes.postCreationContentPlaceholder)
        contentNode.editNode.typingAttributes = TextAttributes.postCreationContent
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(self.cancelPost))
    }

    @objc private func cancelPost() {
        self.delegate?.didCancel()
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return nodes[indexPath.row]
    }

    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        nodes.forEach({ node in
            node.invalidateCalculatedLayout()
            node.setNeedsLayout()
        })
    }
}

//class PostImageViewController: PostViewController {
//    fileprivate let photoPickerProvider: PhotoPickerProvider
//    fileprivate let viewModel: PostImageViewModel
//
//    fileprivate let imageCell: GalleryCell
//    fileprivate let titleCell = TextViewCell(textAttributes: TextAttributes.postCreationTitle)
//    fileprivate let contentCell = TextViewCell(textAttributes: TextAttributes.postCreationContent)
//    fileprivate let imageUploadCellViewModel = GalleryCellViewModel()
//
//    init(photoPickerProvider: PhotoPickerProvider,
//         viewModel: PostImageViewModel) {
//        self.photoPickerProvider = photoPickerProvider
//        self.viewModel = viewModel
//        self.imageCell = GalleryCell(viewModel: imageUploadCellViewModel)
//        super.init()
//        self.cells = [self.titleCell, self.contentCell, self.imageCell]
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imageCell.delegateUpload = self
//        postKeyboardView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
//        contentCell.keyboardAccessoryView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
//        titleCell.keyboardAccessoryView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        contentCell.textView.becomeFirstResponder()
//    }
//
//    @objc private func addPost() {
//        let images = imageUploadCellViewModel.images
//        let title = titleCell.textView.text ?? ""
//        let text = contentCell.textView.text ?? ""
//        viewModel.create(images: images, titlePost: title, descriptionPost: text)
//        DispatchQueue.main.async {
//            self.delegate?.didPost()
//        }
//    }
//}
//
//extension PostImageViewController: ImageUploadCellDelegate {
//    func addPhoto() {
//        photoPickerProvider.pick(controller: self, delegate: imageUploadCellViewModel)
//    }
//}

