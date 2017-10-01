//
//  SliderNodeController.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

class SliderViewControllerFactory: SliderViewFactory {
    let post: PostImage

    init(post: PostImage) {
        self.post = post
    }

    func make() -> SliderView {
        let viewModel = SliderViewModel(post: post)
        return SliderNodeController(viewModel: viewModel)
    }
}

class SliderLayout: ASPagerFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SliderNode: ASDisplayNode {
    let pagerNode = ASPagerNode(collectionViewLayout: SliderLayout())
    fileprivate let footerDetails: FooterSliderNode
    fileprivate let headerControls = HeaderSliderNode()

    init(post: PostImage) {
        footerDetails = FooterSliderNode(post: post)
        super.init()
        addSubnode(pagerNode)
        addSubnode(footerDetails)
        addSubnode(headerControls)
        backgroundColor = UIColor.white
        headerControls.backgroundColor = UIColor.white
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        pagerNode.style.flexGrow = 1
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.alignContent = .center
        stackLayout.children = [headerControls, pagerNode, footerDetails]
        return stackLayout
    }
}

class SliderNodeController: ASViewController<SliderNode>, SliderView {
    fileprivate let sliderNode: SliderNode
    fileprivate let viewModel: SliderViewModel

    weak var delegate: SliderViewDelegate?

    init(viewModel: SliderViewModel) {
        sliderNode = SliderNode(post: viewModel.post)
        self.viewModel = viewModel
        super.init(node: sliderNode)
        sliderNode.pagerNode.setDataSource(self)
        sliderNode.headerControls.closeButtonNode.addTarget(self, action: #selector(self.close), forControlEvents: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func close() {
        delegate?.dismiss()
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
