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
    func make() -> DayFeedView {
        return DayTextureFeedController()
    }
}

class DayTextureFeedController: ASViewController<ASTableNode>, DayFeedView {
    fileprivate let tableNode = ASTableNode()
    fileprivate let toolBar = UIToolbar(frame: CGRect.zero)
    var viewModel: DayTextureViewModel? {
        didSet {
            reload()
        }
    }

    weak var delegate: DayFeedViewDelegate?

    init() {
        super.init(node: tableNode)
        tableNode.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not beene implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.separatorStyle = .none
        tableNode.view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        tableNode.view.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.00)
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
        guard let viewModel = viewModel else { return }
        viewModel.delegate = self
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        title = dateFormatter.string(from: viewModel.day.date)
        tableNode.reloadData()
    }
}

extension DayTextureFeedController: DayTextureViewModelDelegate {
    func didLoadPosts() {
        DispatchQueue.main.async {
            self.tableNode.reloadData()
        }
    }
}

extension DayTextureFeedController: PostCellNodeDelegate {
    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect) {
        delegate?.displaySlider(post: post, index: index, image: image, rect: rect)
    }

    func displayOptions(view: UIView, post: Post) {
        let optionsController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        optionsController.addAction(UIAlertAction(title: "edit", style: .default, handler: { _ in
            self.delegate?.updatePost(post: post)
        }))
        optionsController.addAction(UIAlertAction(title: "delete", style: .destructive, handler: { [weak self] _ in
            self?.viewModel?.removePost(post: post)
        }))
        optionsController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        optionsController.modalPresentationStyle = .popover
        present(optionsController, animated: true, completion: nil)
        optionsController.popoverPresentationController?.sourceView = view
        optionsController.popoverPresentationController?.sourceRect = view.frame
        optionsController.popoverPresentationController?.permittedArrowDirections = .any
    }
}

extension DayTextureFeedController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.models.count ?? 0
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let viewModel = viewModel else {
            return { ASCellNode() }
        }
        let model = viewModel.models[indexPath.row]
        return {
            let cell = PostCellNode(post: model, tableNodeSize: tableNode.calculatedSize)
            cell.delegate = self
            return cell
        }
    }
}
