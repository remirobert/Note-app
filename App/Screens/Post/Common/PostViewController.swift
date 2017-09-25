
//
//  PostViewController.swift
//  App
//
//  Created by Remi Robert on 20/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, PostView {
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain)
    let postKeyboardView: EditPostKeyboardView
    open var cells = [StaticCellType]() {
        didSet {
            cells.forEach { $0.delegate = self }
        }
    }

    weak var delegate: PostViewDelegate?

    init() {
        self.postKeyboardView = EditPostKeyboardView()
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .done, target: self, action: #selector(self.cancelPost))
    }

    @objc private func cancelPost() {
        view.endEditing(true)
        delegate?.didCancel()
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row] as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height
    }
}

extension PostViewController: StaticCellDelegate {
    func didUpdateContent() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension PostViewController {
    fileprivate func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(postKeyboardView)
    }

    fileprivate func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        postKeyboardView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(EditPostKeyboardView.height)
        }
    }

    fileprivate func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: EditPostKeyboardView.height, right: 0)
    }
}
