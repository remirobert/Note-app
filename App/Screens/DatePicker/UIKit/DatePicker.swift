//
//  DatePicker.swift
//  App
//
//  Created by Remi Robert on 16/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class DatePicker: UIView {
    private lazy var datePicker: UIDatePicker = UIDatePicker()
    fileprivate lazy var yearPicker: UIPickerView = UIPickerView()
    fileprivate var yearsPickerDataSource = [Int]()
    private let type: DatePickerType
    private let calendar: Calendar

    init(type: DatePickerType, calendar: Calendar = Calendar.current) {
        self.type = type
        self.calendar = calendar
        super.init(frame: CGRect.zero)

        var view: UIView! = nil
        switch type {
        case .date:
            view = datePicker
        case .year:
            yearsPickerDataSource = ((2017 - 50)...(2017 + 50)).map { $0 }
            yearPicker.delegate = self
            yearPicker.dataSource = self
            view = yearPicker
        }
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var selectedDate: Date {
        switch type {
        case .date:
            return datePicker.date
        case .year:
            let selectedYear = yearsPickerDataSource[yearPicker.selectedRow(inComponent: 0)]
            return Date.fromComponents(day: 15, month: 1, year: selectedYear, calendar: calendar)
        }
    }

    func setDate(date: Date) {
        switch type {
        case .date:
            datePicker.setDate(date, animated: false)
        case .year:
            yearPicker.selectRow(Int(yearsPickerDataSource.count / 2), inComponent: 0, animated: false)
        }
    }
}

extension DatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsPickerDataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let currentYear = yearsPickerDataSource[row]
        return NSAttributedString(string: "\(currentYear)", attributes: TextAttributes.postCreationTitle)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}
