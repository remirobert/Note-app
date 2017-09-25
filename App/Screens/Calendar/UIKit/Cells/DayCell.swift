//
//  DayCell.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class DayCellViewModel: CellViewModel {
    let dateData: DateData
    let isCurrent: Bool
    let reuseIdentifier = String(describing: DayCell.self)

    init(dateData: DateData, isCurrent: Bool = false) {
        self.dateData = dateData
        self.isCurrent = isCurrent
    }

    func contentSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 6,
                      height: UIScreen.main.bounds.size.width / 6)
    }
}

class DayCell: UICollectionViewCell, CellType {
    fileprivate let labelDay = UILabel(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(cellData: CellViewModel) {
        guard let dayData = cellData as? DayCellViewModel else { return }
        self.labelDay.text = "\(dayData.dateData.day)"
        setupViews()
        if dayData.isCurrent {
            contentView.backgroundColor = UIColor.black
            labelDay.textColor = UIColor.white
        }
    }
}

extension DayCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(labelDay)
    }

    fileprivate func setupLayout() {
        labelDay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    fileprivate func setupViews() {
        labelDay.textAlignment = .center
        labelDay.textColor = UIColor.black
        contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
    }
}
