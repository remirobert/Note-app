//
//  SliderNodeController.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

class SliderNodeController: ASViewController<SliderNode>, SliderView {
    fileprivate let sliderNode: SliderNode
    fileprivate let viewModel: SliderViewModel
    fileprivate let startIndex: Int

    weak var delegate: SliderViewDelegate?

    init(viewModel: SliderViewModel, previewTransition: SliderPreviewTransition?) {
        startIndex = previewTransition?.startIndex ?? 0
        sliderNode = SliderNode(post: viewModel.post)
        self.viewModel = viewModel
        super.init(node: sliderNode)
        sliderNode.pagerNode.setDataSource(self)
        sliderNode.pagerNode.setDelegate(self)
        node.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(startIndex + 1) / \(viewModel.images.count)"
        let closeImage = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(self.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.share))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sliderNode.pagerNode.scrollToPage(at: startIndex, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderNode.pagerNode.scrollToPage(at: startIndex, animated: false)
    }

    @objc private func close() {
        self.delegate?.dismiss()
    }

    @objc private func share() {
        let currentIndex = sliderNode.pagerNode.currentPageIndex
        guard let node = sliderNode.pagerNode.nodeForPage(at: currentIndex) as? SliderCellNode,
            let image = node.imageNode.image else {
                return
        }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.modalPresentationStyle = .popover
        present(shareController, animated: true, completion: nil)
        shareController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    }
}

extension SliderNodeController: ASPagerDataSource, ASCollectionDelegate, ASPagerDelegate {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return viewModel.images.count
    }

    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let image = viewModel.images[index]
        let widthPagerNode = self.sliderNode.pagerNode.calculatedSize.width
        return {
            SliderCellNode(image: image, index: index, widthPagerNode: widthPagerNode)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / sliderNode.pagerNode.calculatedSize.width)
        title = "\(page + 1) / \(viewModel.images.count)"
    }
}

