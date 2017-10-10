//
//  PostEditTextNode.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class PostEditTextNode: ASCellNode, ASEditableTextNodeDelegate {
    let editNode = ASEditableTextNode()

    weak var delegate: CellContentUpdateDelegate?

    override init() {
        super.init()
        editNode.tintColor = UIColor.black
        editNode.delegate = self
        editNode.keyboardAppearance = .dark
        addSubnode(editNode)
        selectionStyle = .none
    }

    override func didLoad() {
        super.didLoad()
    }

    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        delegate?.didUpdateContent()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return ASInsetLayoutSpec(insets: insets, child: editNode)
    }
}

