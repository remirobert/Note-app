//
//  SettingsCellNode.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class SettingsCellNode: UITableViewCell {
    fileprivate var switchSettings = UISwitch(frame: CGRect.zero)
    fileprivate var title = UILabel(frame: CGRect.zero)
    private let settingItem: SettingItem

    private let completionValueChanged: ((Bool) -> Swift.Void)

    init(settingItem: SettingItem, completionValueChanged: @escaping (Bool) -> Swift.Void) {
        self.settingItem = settingItem
        self.completionValueChanged = completionValueChanged
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        setupHierarchy()
        setupLayout()
        setupViews()
    }

    private func setupViews() {
        switchSettings.addTarget(self, action: #selector(self.switchValueChanged), for: .valueChanged)
        switchSettings.onTintColor = UIColor.black
        switchSettings.thumbTintColor = UIColor.lightGray

        selectionStyle = .none
        switchSettings.isOn = settingItem.switchValue
        title.text = settingItem.name

        if !settingItem.availaible {
            switchSettings.alpha = 0.5
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func switchValueChanged() {
        self.completionValueChanged(switchSettings.isOn)
    }
}

extension SettingsCellNode {
    fileprivate func setupHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(switchSettings)
    }

    fileprivate func setupLayout() {
        switchSettings.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.equalToSuperview()
            make.right.equalTo(switchSettings.snp.left)
        }
    }
}

