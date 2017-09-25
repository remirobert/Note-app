//
//  TextCellView.swift
//  App
//
//  Created by Remi Robert on 25/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class TextViewComponent: UILabel {
    fileprivate let textAttributes: [String:Any]

    init(textAttributes: [String:Any] = [:]) {
        self.textAttributes = textAttributes
        super.init(frame: CGRect.zero)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(string: String) {
        let attributedText = NSAttributedString(string: string, attributes: textAttributes)
        self.attributedText = attributedText
    }
}

extension TextViewComponent {
    fileprivate func setupViews() {
        numberOfLines = 0
    }
}
