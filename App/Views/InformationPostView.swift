//
//  InformationPostView.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class InformationPostView: UIView {
    private let label = UILabel(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightBold)
        label.textColor = UIColor.darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(date: Date = Date(), dateFormatter: DateFormatter = DateFormatter()) {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: date)
        label.text = dateString
    }
}
