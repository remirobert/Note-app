//
//  CalendarCellNode.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class CalendarCellNode: ASCellNode {
    fileprivate let numberPostsNode = ASTextNode()
    fileprivate let dayTextNode = ASTextNode()

    init(dateData: DateData) {
        super.init()
        addSubnode(dayTextNode)
        addSubnode(numberPostsNode)
//        numberPostsNode.cornerRadius = 10
        numberPostsNode.backgroundColor = UIColor.cyan
        borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        borderWidth = 1
        cornerRadius = 5
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        dayTextNode.attributedText = NSAttributedString(string: "\(dateData.day)", attributes: TextAttributes.calendarDay)
        numberPostsNode.attributedText = NSAttributedString(string: "4")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY,
                                              sizingOptions: .minimumXY,
                                              child: dayTextNode)
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let insetsTextLayout = ASInsetLayoutSpec(insets: insets, child: centerLayout)

        numberPostsNode.style.layoutPosition = CGPoint(x: 50, y: 0)
        numberPostsNode.style.preferredSize = CGSize(width: 10, height: 10)
        return ASAbsoluteLayoutSpec(sizing: .default, children: [insetsTextLayout, numberPostsNode])
    }
}
