//
//  DatePickerViewController.swift
//  App
//
//  Created by Remi Robert on 16/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

enum DatePickerType {
    case date
    case year
}

class DatePickerViewController: UIViewController, DatePickerView {
    fileprivate let toolbar = UIToolbar(frame: CGRect.zero)
    fileprivate let datePicker: DatePicker

    weak var delegate: DatePickerViewDelegate?

    init(type: DatePickerType) {
        datePicker = DatePicker(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.clear
        datePicker.backgroundColor = UIColor.white
        let cancelButton = UIBarButtonItem(title: "cancel", style: .done, target: self, action: nil)
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let selectButton = UIBarButtonItem(title: "select", style: UIBarButtonItemStyle.done, target: self, action: nil)
        toolbar.items = [cancelButton, spaceItem, selectButton]
    }

    @objc private func cancel() {
        delegate?.didCancel()
    }

    @objc private func select() {
        delegate?.didPickDate(date: datePicker.selectedDate)
    }
}

extension DatePickerViewController {
    fileprivate func setupHierarchy() {
        view.addSubview(toolbar)
        view.addSubview(datePicker)
    }

    fileprivate func setupLayout() {
        toolbar.snp.makeConstraints { make in
            make.width.bottom.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        datePicker.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(toolbar.snp.top)
        }
    }
}