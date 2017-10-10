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

class PostViewController: ASViewController<ASTableNode>, ASTableDataSource, PostView, CellContentUpdateDelegate {
    private let tableNode = ASTableNode()
    private let titleNode = PostEditTextNode()
    private let contentNode = PostEditTextNode()
    private let collectionImageNode = PostCollectionImageCellNode()
    private let nodes: [ASCellNode]
    private let toolbar = ToolbarPost()
    private let photoPickerProvider: PhotoPickerProvider
    private let viewModel: PostViewModel

    weak var delegate: PostViewDelegate?

    init(photoPickerProvider: PhotoPickerProvider,
         viewModel: PostViewModel) {
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
        setupToolbarActions()
    }

    private func setupToolbarActions() {
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
        titleNode.editNode.textView.inputAccessoryView = toolbar
        contentNode.editNode.textView.inputAccessoryView = toolbar
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
        DispatchQueue.main.async {
            self.nodes.forEach({ node in
                node.invalidateCalculatedLayout()
                node.setNeedsLayout()
            })
        }
    }
}
