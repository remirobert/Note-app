//
//  OverviewMonthCellNode.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class OverviewMonthCellNode: ASCellNode {
    private let textNode = ASTextNode()
    let sectionCalendar: SectionCalendar

    init(sectionCalendar: SectionCalendar) {
        self.sectionCalendar = sectionCalendar
        super.init()
        addSubnode(textNode)
        let attr = [NSForegroundColorAttributeName: UIColor.black,
                NSFontAttributeName: UIFont.systemFont(ofSize: 70, weight: UIFontWeightRegular)]
        textNode.attributedText = NSAttributedString(string: "\(sectionCalendar.month)", attributes: attr)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetsTitle = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        return ASInsetLayoutSpec(insets: insetsTitle, child: textNode)
    }
}
