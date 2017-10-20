//
//  RMGetDayUseCaseSpec.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Domain
import Quick
import Nimble
import RealmSwift
@testable import RealmPlatform

class RMGetDayUseCaseSpec: QuickSpec {
    private var configuration: Realm.Configuration!
    private var realmTest: Realm!

    override func spec() {
        super.spec()

        describe("RMGetDayUseCase tests") {
            beforeEach {
                self.configuration = Realm.Configuration(inMemoryIdentifier: self.name)
                self.realmTest = try! Realm(configuration: self.configuration)
                try! self.realmTest.write {
                    self.realmTest.deleteAll()
                }
            }
            context("should return") {
                it("the day from the given date") {
                    let date = Date()
                    let rmDay = RMDay(date: date)

                    try! self.realmTest.write {
                        self.realmTest.add(rmDay)
                    }

                    let getDayUseCase = RMGetDayUseCase(configuration: self.configuration)
                    let day = getDayUseCase.get(forDate: date)

                    expect(day.date) == date
                    expect(day.id) == rmDay.id
                }
                it("a standalone object if the day does not exist") {
                    let date = Date()
                    let getDayUseCase = RMGetDayUseCase(configuration: self.configuration)
                    let day = getDayUseCase.get(forDate: date)

                    expect(day.date) == date
                    expect(self.realmTest.objects(RMDay.self)).to(beEmpty())
                }
            }
            context("should create") {
                it("a day from a date") {
                    let date = Date()
                    let getDayUseCase = RMGetDayUseCase(configuration: self.configuration)
                    let day = getDayUseCase.createNewDay(date: date)

                    expect(day.date) == date
                    expect(self.realmTest.objects(RMDay.self).count) == 1
                }
            }
        }
    }
}
