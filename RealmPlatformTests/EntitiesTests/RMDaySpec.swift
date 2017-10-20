//
//  RMDaySpec.swift
//  RealmPlatformTests
//
//  Created by Remi Robert on 20/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import RealmSwift
import Quick
import Nimble
import Domain
import UIKit
@testable import RealmPlatform

class RMDaySpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("RMDay tests") {
            it("should create a RMDay from a Day") {
                let date = Date()
                let day = Day(id: "1234", date: date, numberPosts: 3)

                let rmDay = day.toRMDay()
                expect(rmDay.date) == day.date
                expect(rmDay.id) == day.id
                expect(rmDay.numberPosts) == day.numberPosts
            }
            it("should create a Day from a RMDay") {
                let date = Date()
                let rmDay = RMDay(id: "1234", date: date, numberPosts: 3)

                let day = rmDay.toDay()
                expect(day.date) == rmDay.date
                expect(day.id) == rmDay.id
                expect(day.numberPosts) == rmDay.numberPosts
            }
        }
    }

}
