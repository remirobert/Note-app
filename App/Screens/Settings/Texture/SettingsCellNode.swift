//
//  SettingsCellNode.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import SnapKit

class SettingsCellNode: ASCellNode {
    private lazy var switchSettings = UISwitch()
    private let switchContainer = ASDisplayNode()
    private let titleSettings = ASTextNode()
    private let descriptionSettings = ASTextNode()
    private let settingItem: SettingItem

    init(settingItem: SettingItem) {
        self.settingItem = settingItem
        super.init()
        addSubnode(titleSettings)
        addSubnode(descriptionSettings)
        addSubnode(switchContainer)
        backgroundColor = UIColor.white
        selectionStyle = .none
        titleSettings.attributedText = NSAttributedString(string: settingItem.name, attributes: TextAttributes.settingsTitle)
        descriptionSettings.attributedText = NSAttributedString(string: settingItem.description, attributes: TextAttributes.settingsDescription)
    }

    override func didLoad() {
        super.didLoad()
        switchSettings.isOn = settingItem.switchValue
        switchSettings.onTintColor = UIColor.black
        switchSettings.thumbTintColor = UIColor.lightGray
        switchContainer.view.addSubview(switchSettings)
        switchSettings.frame.origin = CGPoint(x: 70 - switchSettings.frame.size.width - 10, y: 0)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        switchContainer.style.preferredSize = CGSize(width: 70, height: 60)
        let stackTextLayout = ASStackLayoutSpec.vertical()
        stackTextLayout.children = [titleSettings, descriptionSettings]
        stackTextLayout.verticalAlignment = .center

        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 80)
        let textLayout = ASInsetLayoutSpec(insets: insets, child: stackTextLayout)

        switchContainer.style.layoutPosition = CGPoint(x: UIScreen.main.bounds.size.width - 70, y: 10)
        let switchLayout = ASAbsoluteLayoutSpec(children: [switchContainer])
        return ASOverlayLayoutSpec(child: textLayout, overlay: switchLayout)
    }
}

