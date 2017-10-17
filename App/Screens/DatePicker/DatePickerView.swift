//
//  DatePickerView.swift
//  App
//
//  Created by Remi Robert on 16/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe

protocol DatePickerViewDelegate: class {
    func didPickDate(date: Date)
}

protocol DatePickerView: View {
    var delegate: DatePickerViewDelegate? { get set }
}
