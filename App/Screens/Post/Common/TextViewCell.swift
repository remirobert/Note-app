//
//  TextViewCell.swift
//  App
//
//  Created by Remi Robert on 19/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class TextViewCell: UITableViewCell, StaticCellType {
    let textView = UITextView(frame: CGRect.zero)
    let keyboardAccessoryView: EditPostKeyboardView
    fileprivate(set) var height: CGFloat = 50
    fileprivate let textAttributes: [String:Any]

    weak var delegate: StaticCellDelegate?

    init(textAttributes: [String:Any] = [:]) {
        self.textAttributes = textAttributes
        keyboardAccessoryView = EditPostKeyboardView(dismissKeyboardButton: true)
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: TextViewCell.self))
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc fileprivate func dismissKeyboard() {
        keyboardAccessoryView.removeFromSuperview()
        textView.resignFirstResponder()
    }
}

extension TextViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let optionsDrawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin,
                                                             .usesFontLeading,
                                                             .usesDeviceMetrics]
        let heightAttr = textView.attributedText.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 50, height: CGFloat.infinity), options: optionsDrawingOptions, context: nil).size.height
        height = ceil(heightAttr) + 42
        delegate?.didUpdateContent()
        return true
    }
}

extension TextViewCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(textView)
    }

    fileprivate func setupLayout() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
        }
    }

    fileprivate func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white
        textView.isScrollEnabled = false
        textView.typingAttributes = textAttributes
        textView.tintColor = UIColor.black
        textView.delegate = self
        textView.inputAccessoryView = keyboardAccessoryView
        keyboardAccessoryView.buttonDismissKeyboard.addTarget(self,
                                                              action: #selector(self.dismissKeyboard),
                                                              for: .touchUpInside)
    }
}
