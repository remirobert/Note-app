//
//  SettingsNodeController.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class SettingsNodeController: ASViewController<ASTableNode>, SettingsView {
    private let viewModel: SettingsViewModel
    fileprivate let tableNode = ASTableNode()
    fileprivate var cellNodes = [ASCellNode]()
    weak var delegate: SettingsViewDelegate?

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(node: tableNode)
        tableNode.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        tableNode.dataSource = self
        self.viewModel.delegate = self
        configureCellNodes()
    }

    fileprivate func configureCellNodes() {
        let touchIdCell = SettingsCellNode(settingItem: viewModel.touchIdSettingItem) { [weak self] value in
            self?.viewModel.didUpdateTouchId(value: value)
        }
        cellNodes = [
            SettingHeaderCellNode(title: "Security"),
            touchIdCell
        ]
        DispatchQueue.main.async {
            self.tableNode.reloadData()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.tableFooterView = UIView()
        title = "Settings"
    }
}

extension SettingsNodeController: SettingsViewModelDelegate {
    func reloadSettingsItems() {
        configureCellNodes()
    }
}

extension SettingsNodeController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return cellNodes.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return cellNodes[indexPath.row]
    }
}
