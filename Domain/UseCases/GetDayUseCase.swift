//
//  GetDayUseCase.swift
//  Domain
//
//  Created by Remi Robert on 21/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

public protocol GetDayUseCase: class {
    func get(forDate date: Date) -> Day
    func createNewDay(date: Date) -> Day
}

public protocol GetDayUseCaseFactory: class {
    func make() -> GetDayUseCase
}
