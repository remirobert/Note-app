//
//  ButtonPost.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class ButtonPost: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ButtonPost {
    fileprivate func setupViews() {
        backgroundColor = UIColor.black
        setTitle("Post", for: .normal)
        setTitle("Post", for: .highlighted)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.lightGray, for: .highlighted)
    }
}
