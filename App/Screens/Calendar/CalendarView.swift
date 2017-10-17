//
//  CalendarView.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol CalendarViewDelegate: class {
    func didSelectDay(date: Date)
    func displaySettings()
    func displayDatePicker(type: DatePickerType, barButtonItem: UIBarButtonItem?)
}

protocol CalendarViewFactory {
    func make() -> CalendarView
}

protocol CalendarView: View {
    weak var delegate: CalendarViewDelegate? { get set }
}
