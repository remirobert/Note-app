//
//  CellNodeStyle.swift
//  App
//
//  Created by Remi Robert on 29/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class TextAttributes {
    static var textContent: [String:Any] {
        return [NSForegroundColorAttributeName: UIColor.black,
                NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)]
    }

    static var postCreationContent: [String:Any] {
        return [NSForegroundColorAttributeName: UIColor.black,
                NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)]
    }

    static var postCreationTitle: [String:Any] {
        return [NSForegroundColorAttributeName: UIColor.black,
                NSFontAttributeName: UIFont.systemFont(ofSize: 22, weight: UIFontWeightBold)]
    }

    static var footerDate: [String:Any] {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        return [NSParagraphStyleAttributeName: titleParagraphStyle,
                NSForegroundColorAttributeName: UIColor.lightGray,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)]
    }

    static var descriptionImage: [String:Any] {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .right
        return [NSParagraphStyleAttributeName: titleParagraphStyle,
                          NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: UIFont.italicSystemFont(ofSize: 17)]
    }
}
