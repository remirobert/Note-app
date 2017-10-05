//
//  CalendarTextureController.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class CalendarTextureController: ASViewController<ASCollectionNode>, CalendarView {
    fileprivate let collectionNode: ASCollectionNode
    fileprivate let viewModel: CalendarTextureViewModel
    fileprivate var currentSectionCalendar: SectionCalendar!
    fileprivate var performUpdate = true

    weak var delegate: CalendarViewDelegate?

    init(viewModel: CalendarTextureViewModel) {
        self.viewModel = viewModel
        let collectionViewLayout = VerticalCollectionViewLayout()
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
        super.init(node: collectionNode)
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
        collectionNode.view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let todayButton = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.scrollToToday))
        (navigationController as? CalendarNavigationController)?.toolBarActions.items = [space, todayButton]
    }

    @objc private func scrollToToday() {

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
