//
//  AnyDaySpec.swift
//  App
//
//  Created by Remi Robert on 28/08/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Quick
import Nimble
import Domain
@testable import RealmPlatform

class AnyDaySpec: QuickSpec {
    private var realmTest: Realm!

    override func spec() {
        super.spec()

        describe("RMDay tests") {
            it("should create a rmPost from a post with the same data") {
                let date = Date()
                let day = Day(id: "123", date: date)
                let rmDay = day.toRMDay()

                expect(rmDay.date) == day.date
                expect(rmDay.id) == day.id
            }
            it("should create a post from a rmPost with the same data") {
                let date = Date()
                let rmDay = RMDay(id: "123", date: date)
                let day = rmDay.toDay()

                expect(rmDay.date) == day.date
                expect(rmDay.id) == day.id
            }
        }
    }
}
