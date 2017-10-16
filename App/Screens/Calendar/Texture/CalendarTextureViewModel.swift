//
//  CalendarTextureViewModel.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

protocol CalendarTextureViewModelDelegate: class {
    func reloadCalendarSections(updateOffset: Bool)
}

class CalendarTextureViewModel {
    private let currentDate: Date
    fileprivate var dateSelected: Date
    let currentDateData: DateData
    private(set) var currentDisplayedYear: Int = 0
    private let calendar: Calendar
    private let getDayUseCase: GetDayUseCase

    private(set) var sections = [SectionCalendar]()
    private(set) var todaySection: SectionCalendar!
    private(set) var currentSection: IndexPath?
    private(set) var loadedSection: IndexPath?

    private(set) var currentDayOffset: CGFloat?
    private(set) var loadedSectionOffset: CGFloat?

    weak var delegate: CalendarTextureViewModelDelegate?

    init(currentDate: Date = Date(),
         calendar: Calendar = Calendar.current,
         getDayUseCase: GetDayUseCase,
         postSubscriber: PostSubscriber) {
        self.getDayUseCase = getDayUseCase
        self.currentDate = currentDate
        self.dateSelected = currentDate
        self.calendar = calendar
        self.currentDateData = DateData(date: currentDate, calendar: calendar)
        initInitialData()
        postSubscriber.addSubscriber(object: self)
    }

    private func initInitialData() {
        loadYear(fromDate: Date())
    }

    func loadYear(fromDate date: Date, updateOffset: Bool = true) {
        let year = calendar.component(Calendar.Component.year, from: date)
        let month = calendar.component(Calendar.Component.month, from: date)
        let day = calendar.component(Calendar.Component.day, from: date)
        dateSelected = date
        currentDisplayedYear = year
        currentSection = nil
        loadedSection = nil

        sections.removeAll(keepingCapacity: true)
        calendar.monthSymbols.enumerated().forEach { index, _ in
            let dateData = DateData(month: index, year: year)
            let sectionCalendar = SectionCalendar(dateData: dateData, getDayUseCase: getDayUseCase)
            if currentDateData.month == index && currentDateData.year == year {
                currentSection = IndexPath(row: 0, section: index + 1)
            }
            if currentDateData.month == index && currentDateData.year == year {
//                sectionCalendar.setCurrentDay(day: day)
            }
            if month == index + 1 {
                loadedSection = IndexPath(row: 0, section: index + 1)
                sectionCalendar.setCurrentDay(day: day)
            }
            sections.insert(sectionCalendar, at: 0)
        }
        sections.reverse()
        currentDayOffset = nil
        loadedSectionOffset = nil

        if let currentSection = currentSection {
            currentDayOffset = convertIndexPathToOffset(section: currentSection)
        }
        if let loadedSection = loadedSection {
            loadedSectionOffset = month > 1 ? convertIndexPathToOffset(section: loadedSection) : -70
        }
        delegate?.reloadCalendarSections(updateOffset: updateOffset)
    }

    private func convertIndexPathToOffset(section: IndexPath) -> CGFloat {
        let headerHeight: CGFloat = 70
        let offset = (1..<section.section).reduce(0, { result, index -> CGFloat in
            let heightCell = (UIScreen.main.bounds.size.width - 70) / 5 + 10
            let numberLines = CGFloat(ceil(Float(sections[index].days.count) / 5))
            let currentHeightSection = heightCell * numberLines + headerHeight
            return CGFloat(currentHeightSection + result) - 10
        })
        return offset - headerHeight + 10
    }
}

extension CalendarTextureViewModel: PostUpdateSubscriberDelegate {
    func dataDidUpdate() {
        print("🔰 want to update collection")
        loadYear(fromDate: dateSelected, updateOffset: false)
    }
}
