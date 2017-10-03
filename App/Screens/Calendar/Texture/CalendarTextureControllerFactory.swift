//
//  CalendarTextureControllerFactory.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

class CalendarTextureControllerFactory: CalendarViewFactory {
    func make() -> CalendarView {
        return CalendarTextureController()
    }
}
