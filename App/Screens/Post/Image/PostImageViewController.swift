//
//  PostImageViewController.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol CellContentUpdateDelegate: class {
    func didUpdateContent()
}

class EditTextNode: ASCellNode, ASEditableTextNodeDelegate {
    let editNode = ASEditableTextNode()
    let inputKeyboard = EditPostKeyboardView(dismissKeyboardButton: true)

    weak var delegate: CellContentUpdateDelegate?

    override init() {
        super.init()
        editNode.tintColor = UIColor.black
        editNode.delegate = self
        addSubnode(editNode)
        selectionStyle = .none
        inputKeyboard.buttonDismissKeyboard.addTarget(self,
                                                      action: #selector(self.cancelEdit),
                                                      for: .touchUpInside)
    }

    override func didLoad() {
        super.didLoad()
    }

    @objc private func cancelEdit() {
        editNode.resignFirstResponder()
    }

    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        delegate?.didUpdateContent()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return ASInsetLayoutSpec(insets: insets, child: editNode)
    }
}

class CollectionImageCellNode: ASCellNode {
    private let imageNode = ASImageNode()

    init(image: UIImage) {
        super.init()
        imageNode.image = image
        imageNode.contentMode = .scaleAspectFill
        backgroundColor = UIColor.black
        borderWidth = 1
        borderColor = UIColor.lightGray.cgColor
        cornerRadius = 15
        addSubnode(imageNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}

class CollectionImageCellNode2: ASCellNode, ASCollectionDataSource, ASCollectionDelegate, PhotoPickerProviderDelegate {
    private let collectionNode: ASCollectionNode
    private(set) var images = [UIImage]()

    weak var delegate: CellContentUpdateDelegate?

    override init() {
        let collectionViewLayout = VerticalCollectionViewLayout()
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
        super.init()
        addSubnode(collectionNode)
        collectionNode.dataSource = self
        collectionNode.delegate = self
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        collectionNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 5 * 2)
        let insets = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        return ASInsetLayoutSpec(insets: insets, child: collectionNode)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let image = images[indexPath.row]
        return {
            CollectionImageCellNode(image: image)
        }
    }

    func pickedPhoto(image: UIImage?) {
        guard let image = image else { return }
        images.append(image)
        collectionNode.reloadData()
        delegate?.didUpdateContent()
    }

    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: (UIScreen.main.bounds.size.width - 70) / 5,
                          height: (UIScreen.main.bounds.size.width - 70) / 5)
        return ASSizeRange(min: size, max: size)
    }
}

class PostImageViewController: ASViewController<ASTableNode>, ASTableDataSource, PostView, CellContentUpdateDelegate {
    private let tableNode = ASTableNode()
    private let titleNode = EditTextNode()
    private let contentNode = EditTextNode()
    private let collectionImageNode = CollectionImageCellNode2()
    private let nodes: [ASCellNode]
    private let toolbar = ToolbarPost()
    private let photoPickerProvider: PhotoPickerProvider
    private let viewModel: PostImageViewModel

    weak var delegate: PostViewDelegate?

    init(photoPickerProvider: PhotoPickerProvider,
         viewModel: PostImageViewModel) {
        self.photoPickerProvider = photoPickerProvider
        self.viewModel = viewModel
        nodes = [titleNode, contentNode, collectionImageNode]
        super.init(node: tableNode)
        tableNode.dataSource = self

        titleNode.delegate = self
        contentNode.delegate = self
        collectionImageNode.delegate = self

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
        tableNode.view.separatorStyle = .none
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(self.dismissPost))

        titleNode.editNode.textView.inputAccessoryView = toolbar
        contentNode.editNode.textView.inputAccessoryView = toolbar

        let postButton = UIBarButtonItem(title: "post", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.post))
        let imageButton = UIBarButtonItem(image: #imageLiteral(resourceName: "camera-selected"), style: .done, target: self, action: #selector(self.addImage))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let dismissButton = UIBarButtonItem(image: #imageLiteral(resourceName: "dismiss-keyboard"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.dismissKeyboard))
        toolbar.items = [dismissButton, spaceButton, imageButton, postButton]

        guard let postNavigationController = navigationController as? PostNavigationViewController else { return }
        let postButton2 = UIBarButtonItem(title: "post", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.post))
        let imageButton2 = UIBarButtonItem(image: #imageLiteral(resourceName: "camera-selected"), style: .done, target: self, action: #selector(self.addImage))
        postNavigationController.toolBarActions.items = [spaceButton, imageButton2, postButton2]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentNode.editNode.becomeFirstResponder()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func post() {
        if titleNode.editNode.attributedText?.string.isEmpty ?? true &&
            contentNode.editNode.attributedText?.string.isEmpty ?? true &&
            collectionImageNode.images.isEmpty {
            return
        }
        let title = titleNode.editNode.attributedText?.string ?? ""
        let content = contentNode.editNode.attributedText?.string ?? ""
        viewModel.create(images: collectionImageNode.images, titlePost: title, descriptionPost: content)
        dismissPost()
    }

    @objc private func addImage() {
        self.photoPickerProvider.pick(controller: self, delegate: collectionImageNode)
    }

    @objc private func dismissPost() {
        dismissKeyboard()
        self.delegate?.didCancel()
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return nodes[indexPath.row]
    }

    func didUpdateContent() {
        nodes.forEach({ node in
            node.invalidateCalculatedLayout()
            node.setNeedsLayout()
        })
    }
}
