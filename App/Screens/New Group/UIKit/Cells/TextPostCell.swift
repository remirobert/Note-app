 //
//  TextPostCell.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

 class TextPostCellViewModel: CellViewModel {
    let reuseIdentifier: String = String(describing: TextPostCell.self)
    let attributedText: NSAttributedString

    func contentSize() -> CGSize {
        let insetsWidth = TextPostCell.insetsLabel.left + TextPostCell.insetsLabel.right
        let size = CGSize(width: UIScreen.main.bounds.size.width - insetsWidth,
                          height: CGFloat.infinity)
        let optionsDrawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin,
                                                               .usesFontLeading,
                                                               .usesDeviceMetrics]
        let heightText = attributedText.boundingRect(with: size,
                                                     options: optionsDrawingOptions,
                                                     context: nil).size.height
        return CGSize(width: size.width, height: ceil(heightText + 22.0 + TextPostCell.heightInformationView))
    }

    init(text: String) {
        attributedText = NSAttributedString(string: text,
                                            attributes: TextAttributes.textContent)
    }
 }

 class TextPostCell: UICollectionViewCell, CellType {
    fileprivate let label = UILabel(frame: CGRect.zero)
    fileprivate let informationView = InformationPostView(frame: CGRect.zero)
    static let insetsLabel = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    static let heightInformationView: CGFloat = 20.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    func bind(cellData: CellViewModel) {
        guard let cellData = cellData as? TextPostCellViewModel else { return }
        label.attributedText = cellData.attributedText
        informationView.bind()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }

 extension TextPostCell {
    fileprivate func setupHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(informationView)
    }

    fileprivate func setupLayout() {
        informationView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(TextPostCell.insetsLabel)
            make.height.equalTo(TextPostCell.heightInformationView)
        }
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15))
        }
    }

    fileprivate func setupViews() {
        contentView.backgroundColor = UIColor.white
        label.numberOfLines = 0
    }
 }

