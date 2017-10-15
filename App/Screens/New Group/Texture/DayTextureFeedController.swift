//
//  DayTextureFeedController.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain
import SnapKit

class DayTextureControllerFactory: DayFeedViewFactory {
    private let viewModel: DayTextureViewModel

    init(viewModel: DayTextureViewModel) {
        self.viewModel = viewModel
    }

    func make() -> DayFeedView {
        return DayTextureFeedController(viewModel: viewModel)
    }
}

class DayTextureFeedController: ASViewController<ASTableNode>, DayFeedView {
    fileprivate let tableNode = ASTableNode()
    fileprivate let viewModel: DayTextureViewModel
    fileprivate let toolBar = UIToolbar(frame: CGRect.zero)

    weak var delegate: DayFeedViewDelegate?

    init(viewModel: DayTextureViewModel) {
        self.viewModel = viewModel
        super.init(node: tableNode)
        self.viewModel.delegate = self
        tableNode.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not beene implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        title = dateFormatter.string(from: viewModel.day.date)
        tableNode.view.separatorStyle = .none
        tableNode.view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        tableNode.view.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .done, target: self, action: #selector(displayCalendarView))
        setupToolbar()
    }

    private func setupToolbar() {
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: "create", style: .done, target: self, action: #selector(self.addPost))
        (navigationController as? DayFeedNavigationViewController)?.toolBarActions.setItems([space, button], animated: true)
    }

    @objc private func displayCalendarView() {
        delegate?.displayCalendarView()
    }

    @objc private func addPost() {
        delegate?.addPost()
    }

    func reload() {
        tableNode.reloadData()
    }
}

extension DayTextureFeedController: DayFeedViewModelDelegate {
    func didLoadPosts() {
        DispatchQueue.main.async {
            self.tableNode.reloadData()
        }
    }
}

extension DayTextureFeedController: PostCellNodeDelegate {
    func displaySlider(post: PostImage, index: Int, image: UIImage?, rect: CGRect) {
        delegate?.displaySlider(post: post, index: index, image: image, rect: rect)
    }
}

extension DayTextureFeedController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = viewModel.models[indexPath.row]
        return {
            let cell = PostCellNode(post: model)
            cell.delgate = self
            return cell
        }
    }
}
