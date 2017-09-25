
//
//  CalendarViewController.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CalendarController: UIViewController, CalendarView {
    fileprivate let collectionView: UICollectionView
    fileprivate let toolbar = UIToolbar(frame: CGRect.zero)
    private let collectionViewPresenter: CollectionDataSource
    private let viewModel: CalendarViewModel

    weak var delegate: CalendarViewDelegate?

    init(viewModel: CalendarViewModel = CalendarViewModel()) {
        self.viewModel = viewModel
        let collectionViewLayout = VerticalCollectionViewLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: collectionViewLayout)
        collectionViewPresenter = CollectionDataSource(collectionView: collectionView)
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
        collectionViewPresenter.sections = viewModel.sections
        collectionViewPresenter.selectionHandler = { [weak self] _, model in
            DispatchQueue.main.async {
                guard let dayViewModel = model as? DayCellViewModel else { return }
                let date = dayViewModel.dateData.toDate()
                self?.delegate?.didSelectDay(date: date)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: viewModel.currentSection, at: .bottom, animated: false)
    }
}

extension CalendarController {
    fileprivate func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(toolbar)
    }

    fileprivate func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 24, left: 0, bottom: 44, right: 0))
        }
        toolbar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    fileprivate func setupViews() {
        view.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        toolbar.tintColor = UIColor.white
        toolbar.isTranslucent = true
        collectionView.register(cellType: DayCell.self)
        collectionView.registerHeader(supplementaryCellType: HeaderMonthCell.self)
    }
}
