//
//  CalendarYearPickerProvider.swift
//  App
//
//  Created by Remi Robert on 06/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit
import Wireframe

protocol CalendarDateSelectionProviderDelegate: class {
    func didSelectYear(year: Int)
    func didSelectDate(date: Date)
}

protocol CalendarDateSelectionView: View {
    weak var delegate: CalendarDateSelectionProviderDelegate? { get set }
        func present(parentView: View)
}

enum CalendarYearPickerProviderType {
    case year
    case date
}

class CalendarSelectionViewFactory: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    private let type: CalendarYearPickerProviderType
    private var years = [Int]()
    private let view: UIView

    init(type: CalendarYearPickerProviderType,
         calendar: Calendar = Calendar.current,
         currentDate: Date = Date()) {
        self.type = type
        let pickerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        switch type {
        case .year:
            years = ((2017 - 50)...(2017 + 50)).map { $0 }
            let pickerView = UIPickerView(frame: pickerFrame)
            view = pickerView
            super.init()
            pickerView.dataSource = self
            pickerView.delegate = self
        case .date:
            let datePicker = UIDatePicker(frame: pickerFrame)
            datePicker.calendar = calendar
            datePicker.locale = calendar.locale
            datePicker.datePickerMode = .date
            view = datePicker
            super.init()
        }
    }

    func make() -> UIView {
        return view
    }

    func setDate(date: Date) {
        switch type {
        case .year:
            guard let pickerView = view as? UIPickerView else { return }
            pickerView.selectRow(Int(years.count / 2), inComponent: 0, animated: false)
        case .date:
            guard let pickerDate = view as? UIDatePicker else { return }
            pickerDate.setDate(date, animated: false)
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let currentYear = years[row]
        return NSAttributedString(string: "\(currentYear)", attributes: TextAttributes.postCreationTitle)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}

class CalendarYearPickerProvider: UIViewController, View, CalendarDateSelectionView {
    private let pickerViewFactory: CalendarSelectionViewFactory
    private let pickerView: UIView //UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))

    fileprivate let years: [Int]
    let alertViewController: UIAlertController

    weak var delegate: CalendarDateSelectionProviderDelegate?

    init(type: CalendarYearPickerProviderType) {
        self.pickerViewFactory = CalendarSelectionViewFactory(type: type)
        self.pickerView = self.pickerViewFactory.make()
        years = ((2017 - 50)...(2017 + 50)).map { $0 }
        var title: String = ""
        switch type {
        case .year:
            title = "select a year"
        case .date:
            title = "select a specific date"
        }
        alertViewController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        super.init(nibName: nil, bundle: nil)
        preferredContentSize = CGSize(width: 200, height: 200)
        pickerView.backgroundColor = UIColor.white
        view.addSubview(pickerView)

        pickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupAlertController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pickerViewFactory.setDate(date: Date())
//        pickerView.selectRow(Int(years.count / 2), inComponent: 0, animated: false)
    }

    private func setupAlertController() {
        alertViewController.addAction(UIAlertAction(title: "select", style: .default, handler: { _ in
        }))
        alertViewController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alertViewController.isModalInPopover = true
        alertViewController.setValue(self, forKey: "contentViewController")
    }

    func present(parentView: View) {
        parentView.viewController?.present(alertViewController, animated: true, completion: nil)
    }
}

//extension CalendarYearPickerProvider: UIPickerViewDataSource {
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return years.count
//    }
//}
//
//extension CalendarYearPickerProvider: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let currentYear = years[row]
//        return NSAttributedString(string: "\(currentYear)", attributes: TextAttributes.postCreationTitle)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 35
//    }
//}

