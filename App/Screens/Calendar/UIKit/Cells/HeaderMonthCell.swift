
//
//  MonthHeaderCell.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class HeaderMonthViewModel: CellViewModel {
    let reuseIdentifier = String(describing: HeaderMonthCell.self)
    let dateData: DateData

    init(dateData: DateData) {
        self.dateData = dateData
    }

    func contentSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 70)
    }
}

class HeaderMonthCell: UICollectionReusableView, SupplementaryCellType {
    fileprivate let label = UILabel(frame: CGRect.zero)

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
        guard let headerMonth = cellData as? HeaderMonthViewModel else { return }
        label.text = "\(Calendar.current.monthSymbols[headerMonth.dateData.month]) \(headerMonth.dateData.year)"
    }
}

extension HeaderMonthCell {
    fileprivate func setupHierarchy() {
        addSubview(label)
    }

    fileprivate func setupLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }

    fileprivate func setupViews() {
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightHeavy)
        label.textAlignment = .right
        label.backgroundColor = UIColor.white
    }
}
