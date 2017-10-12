//
//  SettingHeaderCellNode.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class SettingHeaderCellNode: ASCellNode {
    private let titleNode = ASTextNode()

    init(title: String) {
        super.init()
        selectionStyle = .none
        addSubnode(titleNode)
        titleNode.attributedText = NSAttributedString(string: title,
                                                      attributes: TextAttributes.calendarHeader)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 40, left: 0, bottom: 10, right: 10)
        let insetsLayout = ASInsetLayoutSpec(insets: insets, child: titleNode)
        return ASRelativeLayoutSpec(horizontalPosition: .end,
                                    verticalPosition: .end,
                                    sizingOption: .minimumHeight,
                                    child: insetsLayout)
    }
}
