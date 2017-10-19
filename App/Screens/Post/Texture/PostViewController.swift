//
//  PostImageViewController.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import AsyncDisplayKit
import RealmPlatform

protocol CellContentUpdateDelegate: class {
    func didUpdateContent()
}

class PostViewController: ASViewController<ASTableNode>, PostView, CellContentUpdateDelegate {
    private let tableNode = ASTableNode()
    private let toolbar = ToolbarPost()
    fileprivate let photoPickerProvider: PhotoPickerProvider
    fileprivate let viewModel: PostViewModel
    fileprivate lazy var operationQueue: OperationQueue = OperationQueue()

    fileprivate let titleNode = PostEditTextNode()
    fileprivate let contentNode = PostEditTextNode()
    fileprivate let collectionImageNode = PostCollectionImageCellNode()
    fileprivate let nodes: [ASCellNode]
    
    fileprivate var colorPost: UIColor = AppColors.postColors[0] {
        didSet {
            tableNode.backgroundColor = colorPost
        }
    }

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

        if let post = viewModel.postUpdate {
            initWithExistantPost(post: post)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.tableFooterView = UIView()
        tableNode.view.separatorStyle = .none
        colorPost = viewModel.postUpdate?.color ?? UIColor.white
        setupNavigationItems()
        setupToolbarActions()
    }
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(self.dismissPost))
        let colorBarButton = ColorBarButtonItem(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        colorBarButton.color = colorPost
        colorBarButton.addTarget(self, action: #selector(self.displayColorPicker), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: colorBarButton)
    }

    private func setupToolbarActions() {
        let postButtonTitle = viewModel.postUpdate == nil ? "post" : "udpate"
        let postButton = UIBarButtonItem(title: postButtonTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.post))
        let imageButton = UIBarButtonItem(image: #imageLiteral(resourceName: "camera-selected"), style: .done, target: self, action: #selector(self.addImage))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let dismissButton = UIBarButtonItem(image: #imageLiteral(resourceName: "dismiss-keyboard"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.dismissKeyboard))
        toolbar.items = [dismissButton, spaceButton, imageButton, postButton]

        guard let postNavigationController = navigationController as? PostNavigationViewController else { return }
        let postButton2 = UIBarButtonItem(title: postButtonTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.post))
        let imageButton2 = UIBarButtonItem(image: #imageLiteral(resourceName: "camera-selected"), style: .done, target: self, action: #selector(self.addImage))
        postNavigationController.toolBarActions.items = [spaceButton, imageButton2, postButton2]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleNode.editNode.textView.inputAccessoryView = toolbar
        contentNode.editNode.textView.inputAccessoryView = toolbar
        contentNode.editNode.becomeFirstResponder()
    }

    private func initWithExistantPost(post: Post) {
        titleNode.editNode.attributedText = NSAttributedString(string: post.titlePost,
                                                               attributes: TextAttributes.postCreationTitle)
        contentNode.editNode.attributedText = NSAttributedString(string: post.descriptionPost,
                                                                 attributes: TextAttributes.postCreationContent)
        print("🚾 display images : \(post.images)")
        operationQueue.addOperation { [weak self] in
            let images = post.images.map({ (image: String) -> UIImage? in
                var path = DefaultFileManager.documentUrl
                path?.appendPathComponent(image)
                guard let pathUrl = path else {
                    return nil
                }
                return UIImage(contentsOfFile: pathUrl.absoluteString)
            }).flatMap({ $0 })
            OperationQueue.main.addOperation {
                self?.collectionImageNode.images = images
            }
        }
    }
}

extension PostViewController {
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc fileprivate func post() {
        if titleNode.editNode.attributedText?.string.isEmpty ?? true &&
            contentNode.editNode.attributedText?.string.isEmpty ?? true &&
            collectionImageNode.images.isEmpty {
            return
        }
        let title = titleNode.editNode.attributedText?.string ?? ""
        let content = contentNode.editNode.attributedText?.string ?? ""

        if let _ = viewModel.postUpdate {
            viewModel.update(images: collectionImageNode.images,
                             titlePost: title,
                             descriptionPost: content,
                             color: colorPost)
        } else {
            viewModel.create(images: collectionImageNode.images,
                             titlePost: title,
                             descriptionPost: content,
                             color: colorPost)
        }
        dismissPost()
    }

    @objc fileprivate func addImage() {
        self.photoPickerProvider.pick(controller: self, delegate: collectionImageNode)
    }

    @objc fileprivate func dismissPost() {
        dismissKeyboard()
        dismiss(animated: true)
    }
    
    @objc fileprivate func displayColorPicker() {
        let colorController = ColorPickerPostController()
        colorController.completionColor = { [weak self] color in
            self?.colorPost = color
            (self?.navigationItem.rightBarButtonItem?.customView as? ColorBarButtonItem)?.color = color
        }
        colorController.modalPresentationStyle = .popover
        colorController.preferredContentSize = CGSize(width: 300, height: 60)
        present(colorController, animated: true, completion: nil)
        colorController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        colorController.popoverPresentationController?.permittedArrowDirections = .any
    }
}

extension PostViewController: ASTableDataSource {
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
