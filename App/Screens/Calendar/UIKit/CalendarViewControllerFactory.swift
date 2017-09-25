//
//  CalendarViewFactory.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CalendarViewControllerFactory: CalendarViewFactory {
    func make() -> CalendarView {
        return CalendarController()
    }
}
