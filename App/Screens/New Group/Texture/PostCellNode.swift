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
    func displaySlider(post: PostImage)
}

class BackgroundPostCellNode: ASDisplayNode {
    override init() {
        super.init()
        backgroundColor = UIColor.white
        cornerRadius = 5
        shadowColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        shadowRadius = 15
        shadowOpacity = 1
        shadowOffset = CGSize(width: 2, height: 2)
    }

    override func didLoad() {
        super.didLoad()
        layer.masksToBounds = false
    }
}

class PostCellNode: ASCellNode {
    fileprivate let post: PostImage
    fileprivate let titleTextNode = ASTextNode()
    fileprivate let contentTextNode = ASTextNode()
    fileprivate let galleryNode: ImageGalleryNode
    fileprivate let background = BackgroundPostCellNode()
    fileprivate let timeTextNode = ASTextNode()

    weak var delgate: PostCellNodeDelegate?

    init(post: PostImage) {
        self.post = post
        galleryNode = ImageGalleryNode(images: post.images)
        super.init()
        setupHierarchy()
        setupNodes(post: post)
        selectionStyle = .none
        galleryNode.delegate = self
    }
}

extension PostCellNode {
    fileprivate func setupHierarchy() {
        addSubnode(background)
        addSubnode(titleTextNode)
        addSubnode(contentTextNode)
        addSubnode(galleryNode)
        addSubnode(timeTextNode)
    }

    fileprivate func setupNodes(post: PostImage) {
        titleTextNode.attributedText = NSAttributedString(string: post.titlePost, attributes: TextAttributes.postCreationTitle)
        contentTextNode.attributedText = NSAttributedString(string: post.descriptionPost, attributes: TextAttributes.postCreationContent)
        timeTextNode.attributedText = NSAttributedString(string: "10 mins ago", attributes: TextAttributes.postCreationContent)
    }
}

extension PostCellNode: ImageGalleryCellNodeDelegate {
    func didSelectImage(index: Int) {
        self.delgate?.displaySlider(post: post)
    }
}

extension PostCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.spacing = 10
        let insets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        galleryNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width - 80, height: galleryNode.height)
        stackLayout.children = [titleTextNode, contentTextNode, galleryNode, timeTextNode]

        let insetsStackLayout = ASInsetLayoutSpec(insets: insets, child: stackLayout)
        let insetsBackground = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return ASBackgroundLayoutSpec(child: insetsStackLayout, background: ASInsetLayoutSpec(insets: insetsBackground, child: background))
    }
}
