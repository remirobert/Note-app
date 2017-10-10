//
//  SliderNodeController.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

class SliderNodeController: ASViewController<SliderNode>, SliderView, SliderNodeTransitionStateDelegate {
    fileprivate let sliderNode: SliderNode
    fileprivate let viewModel: SliderViewModel
    fileprivate let startIndex: Int

    weak var delegate: SliderViewDelegate?

    init(viewModel: SliderViewModel, previewTransition: SliderPreviewTransition?) {
        startIndex = previewTransition?.startIndex ?? 0
        sliderNode = SliderNode(post: viewModel.post, previewTransition: previewTransition)
        self.viewModel = viewModel
        super.init(node: sliderNode)
        sliderNode.pagerNode.setDataSource(self)
        node.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "1 / \(viewModel.images.count)"
        sliderNode.delegate = self
        let closeImage = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(self.close))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sliderNode.pagerNode.scrollToPage(at: startIndex, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderNode.pagerNode.isHidden = true
        sliderNode.pagerNode.scrollToPage(at: startIndex, animated: false)
        sliderNode.transitionState = .displayed
        sliderNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
    }

    @objc func close() {
        sliderNode.pagerNode.isHidden = true
        sliderNode.imageNode.isHidden = false
        sliderNode.transitionState = .dismissing
        sliderNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
    }

    func didFinishStateTransition(state: SliderNodeTransitionState) {
        if state == .dismissing {
            self.delegate?.dismiss()
        }
    }
}

extension SliderNodeController: ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return viewModel.images.count
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        title = "\(index + 1) / \(viewModel.images.count)"
        let image = viewModel.images[index]
        return {
            SliderCellNode(image: image)
        }
    }
}
