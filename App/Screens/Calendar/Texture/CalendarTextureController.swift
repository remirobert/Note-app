//
//  CalendarTextureController.swift
//  App
//
//  Created by Remi Robert on 02/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class CalendarTextureController: ASViewController<ASPagerNode>, CalendarView {
    fileprivate let pagerNode: ASPagerNode
    fileprivate let viewModel: CalendarTextureViewModel

    weak var delegate: CalendarViewDelegate?

    init(viewModel: CalendarTextureViewModel = CalendarTextureViewModel()) {
        self.viewModel = viewModel
        let layout = ASPagerFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        pagerNode = ASPagerNode(collectionViewLayout: layout)
        super.init(node: pagerNode)
        pagerNode.setDelegate(self)
        pagerNode.setDataSource(self)
        pagerNode.invalidateCalculatedLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Takagi"
        viewModel.loadNextMonth()
        viewModel.loadPreviousMonth()
        pagerNode.reloadData()
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

extension CalendarTextureController: ASPagerDataSource, ASPagerDelegate {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return viewModel.sections.count
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let sectionCalendar = viewModel.sections[index]
        return {
            OverviewMonthCellNode(sectionCalendar: sectionCalendar)
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, willDisplayItemWith node: ASCellNode) {
        guard let overviewNode = node as? OverviewMonthCellNode else { return }

        if let last = viewModel.sections.last {
            if overviewNode.sectionCalendar == last {
                viewModel.loadNextMonth()
                pagerNode.reloadData()
            }
        }
        if let first = viewModel.sections.first {
            print("💚 reload next : \(overviewNode.sectionCalendar.year)/\(overviewNode.sectionCalendar.month)")
            print("💙 reload next : \(first.year)/\(first.month)")
            if overviewNode.sectionCalendar == first {
                pagerNode.performBatchUpdates({
                    viewModel.loadPreviousMonth()
                }, completion: nil)
//                pagerNode.reloadData()
            }
        }
    }
}
