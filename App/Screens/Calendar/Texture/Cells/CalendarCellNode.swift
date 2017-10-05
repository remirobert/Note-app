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
        cornerRadius = 10
        style.preferredSize = CGSize(width: 20, height: 20)
        numberTextNode.attributedText = NSAttributedString(string: "\(numberPost)", attributes: TextAttributes.numberPostDay)
        addSubnode(numberTextNode)
    }

    func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: numberTextNode)
    }
}

class CalendarCellNode: ASCellNode {
    fileprivate let numberPostsNode = NumberPostDayNode(numberPost: 3)
    fileprivate let dayTextNode = ASTextNode()

    init(dateData: DateData) {
        super.init()
        addSubnode(dayTextNode)
        addSubnode(numberPostsNode)
        borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        borderWidth = 1
        cornerRadius = 5
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        dayTextNode.attributedText = NSAttributedString(string: "\(dateData.day)", attributes: TextAttributes.calendarDay)
        numberPostsNode.attributedText = NSAttributedString(string: "4")
    }

    override func didLoad() {
        super.didLoad()
        numberPostsNode.layer.masksToBounds = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY,
                                              sizingOptions: .minimumXY,
                                              child: dayTextNode)
        let numberPostLayout = ASRelativeLayoutSpec(horizontalPosition: .end,
                                                    verticalPosition: .start,
                                                    sizingOption: .minimumSize,
                                                    child: numberPostsNode)
        return ASOverlayLayoutSpec(child: centerLayout, overlay: numberPostLayout)
    }
}
