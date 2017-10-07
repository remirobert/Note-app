//
//  CalendarCellNode.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class NumberPostDayNode: ASDisplayNode {
    private let numberTextNode = ASTextNode()

    init(numberPost: Int) {
        super.init()
        backgroundColor = UIColor.black
        borderWidth = 1
        borderColor = UIColor.white.cgColor
        cornerRadius = 15
        style.preferredSize = CGSize(width: 30, height: 30)
        numberTextNode.attributedText = NSAttributedString(string: "\(numberPost)",
            attributes: TextAttributes.numberPostDay)
        addSubnode(numberTextNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: numberTextNode)
    }
}

class CalendarCellNode: ASCellNode {
    fileprivate let numberPostsNode: NumberPostDayNode?
    fileprivate let dayTextNode = ASTextNode()

    init(dateData: DateData) {
        if let day = dateData.dayModel, day.numberPosts > 0 {
            numberPostsNode = NumberPostDayNode(numberPost: day.numberPosts)
        } else {
            numberPostsNode = nil
        }
        super.init()
        addSubnode(dayTextNode)
        if let numberPostsNode = numberPostsNode {
            addSubnode(numberPostsNode)
        }
        borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        borderWidth = 1
        cornerRadius = 5
        if dateData.dayModel?.numberPosts ?? 0 > 0 {
            backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
        } else {
            backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        let stringDay = "\(dateData.day)"
        dayTextNode.attributedText = NSAttributedString(string: stringDay,
                                                        attributes: TextAttributes.calendarDay)
        if dateData.isCurrentDay {
            borderWidth = 4
            borderColor = UIColor.black.cgColor
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY,
                                              sizingOptions: .minimumXY,
                                              child: dayTextNode)
        if let numberPostsNode = numberPostsNode {
            let numberPostLayout = ASRelativeLayoutSpec(horizontalPosition: .end,
                                                        verticalPosition: .start,
                                                        sizingOption: .minimumSize,
                                                        child: numberPostsNode)
            return ASOverlayLayoutSpec(child: centerLayout, overlay: numberPostLayout)
        }
        return centerLayout
    }
}
