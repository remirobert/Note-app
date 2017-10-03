//
//  CalendarCellNode.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class CalendarCellNode: ASCellNode {
    fileprivate let dayTextNode = ASTextNode()

    init(dateData: DateData) {
        super.init()
        addSubnode(dayTextNode)
        dayTextNode.attributedText = NSAttributedString(string: "\(dateData.day)", attributes: TextAttributes.calendarDay)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: dayTextNode)
    }
}
