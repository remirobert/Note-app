//
//  CalendarTextureController.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import SnapKit

class CalendarTextureController: ASViewController<ASCollectionNode>, CalendarView {
    fileprivate let collectionNode: ASCollectionNode
    fileprivate let viewModel: CalendarTextureViewModel
    fileprivate var currentSectionCalendar: SectionCalendar!
    fileprivate var performUpdate = true
    fileprivate var firstDisplay = true

    weak var delegate: CalendarViewDelegate?

    init(viewModel: CalendarTextureViewModel) {
        self.viewModel = viewModel
        let collectionViewLayout = VerticalCollectionViewLayout()
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
        super.init(node: collectionNode)
        viewModel.delegate = self
        currentSectionCalendar = viewModel.todaySection
        collectionNode.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
        collectionNode.dataSource = self
        collectionNode.delegate = self
        collectionNode.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Takagi"
        collectionNode.view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 70, right: 10)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureToolbar()
        if firstDisplay {
            scrollToToday()
        }
    }

    fileprivate func configureToolbar() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let todayButton = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(self.scrollToToday))
        let yearButton = UIBarButtonItem(title: "\(viewModel.currentDisplayedYear)", style: .done, target: self, action: #selector(self.selectYearCalendar))
        let dateButton = UIBarButtonItem(image: #imageLiteral(resourceName: "selectDate"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.selectDateCalendar))
        (navigationController as? CalendarNavigationController)?.toolBarActions.items = [dateButton, yearButton, space, todayButton]
    }

    @objc private func selectDateCalendar() {
        let controller = CalendarYearPickerProvider(type: .date)
        controller.delegate = self
        self.present(controller.alertViewController, animated: true, completion: nil)
    }

    @objc private func selectYearCalendar() {
        let controller = CalendarYearPickerProvider(type: .year)
        controller.delegate = self
        self.present(controller.alertViewController, animated: true, completion: nil)
    }

    @objc private func scrollToToday() {
        viewModel.loadYear(fromDate: Date())
        configureToolbar()
    }
}

extension CalendarTextureController: CalendarTextureViewModelDelegate {
    func reloadCalendarSections() {
        collectionNode.reloadData()
        guard let offset = viewModel.loadedSectionOffset else { return }
        let animated = !firstDisplay
        firstDisplay = false
        DispatchQueue.main.async {
            self.collectionNode.view.setContentOffset(CGPoint(x: self.collectionNode.view.contentOffset.x,
                                                              y: offset),
                                                      animated: animated)
        }
    }
}

extension CalendarTextureController: CalendarDateSelectionProviderDelegate {
    func didSelectDate(date: Date) {
        viewModel.loadYear(fromDate: date)
        configureToolbar()
        collectionNode.reloadData()

        guard let offset = viewModel.loadedSectionOffset else { return }
        DispatchQueue.main.async {
            self.collectionNode.view.setContentOffset(CGPoint(x: self.collectionNode.view.contentOffset.x,
                                                              y: offset),
                                                      animated: true)
        }
    }
}

extension CalendarTextureController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return viewModel.sections.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].days.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let dayData = viewModel.sections[indexPath.section].days[indexPath.row]
        return {
            return CalendarCellNode(dateData: dayData)
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNodeBlock {
        let sectionCalendar = viewModel.sections[indexPath.section]
        return {
            return HeaderCellNode(dateData: sectionCalendar)
        }
    }
}

extension CalendarTextureController: ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let date = viewModel.sections[indexPath.section].days[indexPath.row].toDate()
        delegate?.didSelectDay(date: date)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: (UIScreen.main.bounds.size.width - 70) / 5,
                          height: (UIScreen.main.bounds.size.width - 70) / 5)
        return ASSizeRange(min: size, max: size)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        let size = CGSize(width: UIScreen.main.bounds.size.width,
                          height: 70)
        return ASSizeRange(min: size, max: size)
    }
}
