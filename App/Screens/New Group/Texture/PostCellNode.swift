//
//  PostCellNode.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

protocol PostCellNodeDelegate: class {
    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect)
    func displayOptions(view: UIView, post: Post)
}

class BackgroundPostCellNode: ASDisplayNode {
    override init() {
        super.init()
        backgroundColor = UIColor.white
        cornerRadius = 5
        shadowColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        shadowRadius = 5
        shadowOpacity = 1
        shadowOffset = CGSize(width: 1, height: 1)
    }

    override func didLoad() {
        super.didLoad()
        layer.masksToBounds = false
    }
}

class PostCellNode: ASCellNode {
    fileprivate let post: Post
    fileprivate let titleTextNode = ASTextNode()
    fileprivate let contentTextNode = ASTextNode()
    fileprivate let galleryNode: ImageGalleryNode
    fileprivate let background = BackgroundPostCellNode()
    fileprivate let footerNode = FooterPostCellNode()
    fileprivate let tableNodeSize: CGSize
    fileprivate var nodes = [ASDisplayNode]()

    weak var delegate: PostCellNodeDelegate?

    init(post: Post, tableNodeSize: CGSize) {
        self.post = post
        self.tableNodeSize = tableNodeSize
        galleryNode = ImageGalleryNode(images: post.images,
                                       widthTableNode: tableNodeSize.width)
        if !post.titlePost.isEmpty {
            nodes.append(titleTextNode)
        }
        if !post.descriptionPost.isEmpty {
            nodes.append(contentTextNode)
        }
        if post.images.count > 0 {
            nodes.append(galleryNode)
        }
        nodes.append(footerNode)

        super.init()
        setupHierarchy()
        setupNodes(post: post)
        selectionStyle = .none
        galleryNode.delegate = self
        footerNode.buttonOptions.addTarget(self,
                                           action: #selector(self.optionsPost),
                                           forControlEvents: .touchUpInside)
    }

    @objc private func optionsPost() {
        DispatchQueue.main.async {
            self.delegate?.displayOptions(view: self.view, post: self.post)
        }
    }
}

extension PostCellNode {
    fileprivate func setupHierarchy() {
        addSubnode(background)
        nodes.forEach {
            addSubnode($0)
        }
    }

    fileprivate func setupNodes(post: Post) {
        galleryNode.style.preferredSize = CGSize(width: tableNodeSize.width - 80, height: galleryNode.height)
        titleTextNode.attributedText = NSAttributedString(string: post.titlePost, attributes: TextAttributes.postCreationTitle)
        contentTextNode.attributedText = NSAttributedString(string: post.descriptionPost, attributes: TextAttributes.postCreationContent)
        footerNode.timeTextNode.attributedText = NSAttributedString(string: post.date.timeAgo(), attributes: TextAttributes.footerDate)
        background.backgroundColor = post.color
    }
}

extension PostCellNode: ImageGalleryCellNodeDelegate {
    func didSelectImage(index: Int, image: UIImage?, rect: CGRect) {
        self.delegate?.displaySlider(post: post, index: index, image: image, rect: rect)
    }
}

extension PostCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.spacing = 10
        let insets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        stackLayout.children = nodes
        let insetsStackLayout = ASInsetLayoutSpec(insets: insets, child: stackLayout)
        let insetsBackground = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return ASBackgroundLayoutSpec(child: insetsStackLayout, background: ASInsetLayoutSpec(insets: insetsBackground, child: background))
    }
}
