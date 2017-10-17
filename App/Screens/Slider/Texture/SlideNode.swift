//
//  SlideNode.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

class SliderLayout: ASPagerFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SliderNode: ASDisplayNode {
    let pagerNode = ASPagerNode(collectionViewLayout: SliderLayout())

    init(post: Post) {
        super.init()
        addSubnode(pagerNode)
        pagerNode.backgroundColor = UIColor.black
        backgroundColor = UIColor.clear
    }

}

extension SliderNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        pagerNode.style.flexGrow = 1
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.alignContent = .center
        stackLayout.children = [pagerNode]
        return stackLayout
    }
}

