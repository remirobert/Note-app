
//
//  UIKitCollectionViewController.swift
//  App
//
//  Created by Remi Robert on 15/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit
import Domain

class DayFeedController: UIViewController, DayFeedView {
    fileprivate let collectionView: UICollectionView
    fileprivate let toolbar = UIToolbar(frame: CGRect.zero)
    private let collectionDataSource: CollectionDataSource
    private let viewModel: DayFeedViewModel

    weak var delegate: DayFeedViewDelegate?

    init(viewModel: DayFeedViewModel) {
        self.viewModel = viewModel
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: VerticalCollectionViewLayout())
        collectionDataSource = CollectionDataSource(collectionView: collectionView)
        super.init(nibName: nil, bundle: nil)
        collectionDataSource.sections = self.viewModel.section
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload() {
        viewModel.reloadSections()
        collectionDataSource.sections = viewModel.section
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        title = dateFormatter.string(from: viewModel.day.date)

        let calendarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .done, target: self, action: #selector(addPost))
        toolbar.items = [calendarButton]
        toolbar.isTranslucent = false
        toolbar.tintColor = UIColor.white
        toolbar.barTintColor = UIColor.black

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .done, target: self, action: #selector(displayCalendarView))
    }

    @objc private func displayCalendarView() {
        delegate?.displayCalendarView()
    }

    @objc private func addPost() {
        delegate?.addPost()
    }
}

extension DayFeedController {
    fileprivate func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(toolbar)
    }

    fileprivate func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        toolbar.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    fileprivate func setupViews() {
        collectionView.backgroundColor = UIColor.white
        collectionView.register(cellType: TextPostCell.self)
        collectionView.register(cellType: ImagePostCell.self)
        collectionView.register(cellType: PostCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 44, right: 0)
    }
}
