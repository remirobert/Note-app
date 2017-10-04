//
//  HeaderCellNode.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class HeaderCellNode: ASCellNode {
    private let textNode = ASTextNode()

    init(dateData: SectionCalendar, calendar: Calendar = Calendar.current) {
        super.init()
        addSubnode(textNode)
        let text = "\(calendar.monthSymbols[dateData.month]) \(dateData.year)"
        textNode.attributedText = NSAttributedString(string: text, attributes: TextAttributes.calendarHeader)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let insetsLayout = ASInsetLayoutSpec(insets: insets, child: textNode)
        return ASRelativeLayoutSpec(horizontalPosition: .end,
                                    verticalPosition: .end,
                                    sizingOption: .minimumHeight,
                                    child: insetsLayout)
    }
}
