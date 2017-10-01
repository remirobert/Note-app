//
//  FooterSliderNode.swift
//  App
//
//  Created by Remi Robert on 01/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

class FooterSliderNode: ASDisplayNode {
    fileprivate let topBorder = ASDisplayNode()
    fileprivate let titleTextNode = ASTextNode()
    fileprivate let dateTextNode = ASTextNode()

    init(post: PostImage) {
        super.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: post.date)
        dateTextNode.attributedText = NSAttributedString(string: dateString,
                                                         attributes: TextAttributes.sliderFooter)
        titleTextNode.attributedText = NSAttributedString(string: post.titlePost,
                                                          attributes: TextAttributes.sliderFooter)
        addSubnode(titleTextNode)
        addSubnode(dateTextNode)
        addSubnode(topBorder)
        topBorder.backgroundColor = UIColor.white
        backgroundColor = UIColor.clear
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        topBorder.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
        topBorder.style.flexGrow = 1
        let stackText = ASStackLayoutSpec.vertical()
        stackText.children = [titleTextNode, dateTextNode]
        let insetsText = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        let layoutInsets = ASInsetLayoutSpec(insets: insetsText, child: stackText)
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.alignContent = .center
        stackLayout.children = [topBorder, layoutInsets]
        return stackLayout
    }
}
