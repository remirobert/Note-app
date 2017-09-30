//
//  SliderNodeController.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class SliderViewControllerFactory {
    let images: [String]

    init(images: [String]) {
        self.images = images
    }

    func make() -> SliderView {
        let viewModel = SliderViewModel(images: images)
        return SliderNodeController(viewModel: viewModel)
    }
}

class SliderNodeController: ASPagerNode, SliderView {
    fileprivate let viewModel: SliderViewModel

    init(viewModel: SliderViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

extension SliderNodeController: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return viewModel.images.count
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let image = viewModel.images[index]
        return {
            SliderCellNode(image: image)
        }
    }
}
