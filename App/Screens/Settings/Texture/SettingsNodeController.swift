//
//  SettingsNodeController.swift
//  App
//
//  Created by Remi Robert on 11/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class SettingsNodeController: UIViewController, SettingsView {
    private let viewModel: SettingsViewModel
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    fileprivate var cells = [UITableViewCell]()

    weak var delegate: SettingsViewDelegate?

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureCellNodes()
    }

    fileprivate func configureCellNodes() {
        let touchIdCell = SettingsCellNode(settingItem: viewModel.touchIdSettingItem) { [weak self] value in
            self?.viewModel.didUpdateTouchId(value: value)
        }
        cells = [
            touchIdCell
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .done, target: self, action: #selector(self.close))
    }

    @objc private func close() {
        delegate?.dismiss()
    }
}

extension SettingsNodeController: SettingsViewModelDelegate {
    func reloadSettingsItems() {
        configureCellNodes()
    }
}

extension SettingsNodeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
