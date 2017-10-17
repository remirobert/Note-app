//
//  FooterPostCellNode.swift
//  App
//
//  Created by Remi Robert on 17/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class FooterPostCellNode: ASDisplayNode {
    let timeTextNode = ASTextNode()
    let buttonOptions = ASButtonNode()

    override init() {
        super.init()
        buttonOptions.setImage(#imageLiteral(resourceName: "post-options-unselected"), for: UIControlState.normal)
        buttonOptions.setImage(#imageLiteral(resourceName: "post-options-selected"), for: UIControlState.focused)
        buttonOptions.imageNode.contentMode = .scaleAspectFit
        addSubnode(timeTextNode)
        addSubnode(buttonOptions)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        timeTextNode.style.flexGrow = 1
        buttonOptions.style.preferredSize = CGSize(width: 30, height: 30)
        let stackLayout = ASStackLayoutSpec.horizontal()
        stackLayout.verticalAlignment = .center
        stackLayout.children = [timeTextNode, buttonOptions]
        return stackLayout
    }
}
