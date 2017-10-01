//
//  HeaderSliderNode.swift
//  App
//
//  Created by Remi Robert on 01/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class HeaderSliderNode: ASDisplayNode {
    let closeButtonNode = ASButtonNode()

    override init() {
        super.init()
        closeButtonNode.backgroundColor = UIColor.red
        addSubnode(closeButtonNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        closeButtonNode.style.preferredSize = CGSize(width: 40, height: 40)
        let layout = ASStackLayoutSpec.horizontal()
        layout.children = [closeButtonNode]
        return layout
    }
}
