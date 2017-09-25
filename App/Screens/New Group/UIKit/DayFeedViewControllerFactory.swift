//
//  DayFeedViewControllerFactory.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class DayFeedViewControllerFactory: DayFeedViewFactory {
    private let viewModel: DayFeedViewModel

    init(viewModel: DayFeedViewModel) {
        self.viewModel = viewModel
    }

    func make() -> DayFeedView {
        return DayFeedController(viewModel: viewModel)
    }
}
