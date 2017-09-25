//
//  EditPostKeyboardView.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class EditPostKeyboardView: UIView {
    let buttonPost = ButtonPost(frame: CGRect.zero)
    let buttonDismissKeyboard = UIButton(type: .custom)
    fileprivate let dismissKeyboardButton: Bool
    static let height: CGFloat = 50

    init(dismissKeyboardButton: Bool = false) {
        self.dismissKeyboardButton = dismissKeyboardButton
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: EditPostKeyboardView.height))
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditPostKeyboardView {
    fileprivate func setupHierarchy() {
        addSubview(buttonPost)
        if dismissKeyboardButton {
            addSubview(buttonDismissKeyboard)
        }
    }

    fileprivate func setupLayout() {
        buttonPost.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-20)
        }
        if dismissKeyboardButton {
            buttonDismissKeyboard.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: EditPostKeyboardView.height - 20,
                                         height: EditPostKeyboardView.height - 20))
                make.left.equalToSuperview().offset(20)
            }
        }
    }

    fileprivate func setupViews() {
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        buttonPost.layer.cornerRadius = (EditPostKeyboardView.height - 20) / 2
        buttonDismissKeyboard.setImage(#imageLiteral(resourceName: "dismiss-keyboard"), for: .normal)
        buttonDismissKeyboard.setImage(#imageLiteral(resourceName: "dismiss-keyboard"), for: .highlighted)
    }
}
