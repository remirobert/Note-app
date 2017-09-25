//
//  TestSpec.swift
//  Pods
//
//  Created by Remi Robert on 26/08/2017.
//
//

import Quick
import Nimble
@testable import Domain

class DayEquatableSpec: QuickSpec {
    override func spec() {
        super.spec()

        describe("Test Day Equatability model") {
            it("should return true if equal") {

                let date = Date()
                let day1 = Day(id: "123", date: date)
                let day2 = Day(id: "123", date: date)

                expect(day1) == day2
            }
            it("should return false if the ids are not equal") {
                let date = Date()
                let day1 = Day(id: "123", date: date)
                let day2 = Day(id: "321", date: date)

                expect(day1 == day2) == false
            }
            it("should return false if the date are not equal") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/YYYY"
                let date1 = dateFormatter.date(from: "10/10/1990")
                let date2 = Date()
                let day1 = Day(id: "123", date: date1!)
                let day2 = Day(id: "123", date: date2)

                expect(day1 == day2) == false
            }
        }
    }
}
