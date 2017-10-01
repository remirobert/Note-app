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
        pagerNode.backgroundColor = UIColor.black
        backgroundColor = UIColor.black
        headerControls.backgroundColor = UIColor.lightGray
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let sliderLayout = ASWrapperLayoutSpec(layoutElement: pagerNode)
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.alignContent = .center
        headerControls.style.flexGrow = 1
        footerDetails.style.flexGrow = 1
        stackLayout.children = [headerControls, sliderLayout, footerDetails]
        return stackLayout


//        let layoutPager = ASWrapperLayoutSpec(layoutElement: pagerNode)
//        let headerLayout = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start,
//                                                verticalPosition: ASRelativeLayoutSpecPosition.start,
//                                                sizingOption: ASRelativeLayoutSpecSizingOption.minimumWidth,
//                                                child: headerControls)
//        let footerLayout = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start,
//                                                verticalPosition: ASRelativeLayoutSpecPosition.end,
//                                                sizingOption: ASRelativeLayoutSpecSizingOption.minimumWidth,
//                                                child: footerDetails)
//
//        let stackLayoutControls = ASStackLayoutSpec.vertical()
//        stackLayoutControls.alignContent = .spaceBetween
//        stackLayoutControls.flexWrap = .noWrap
//        stackLayoutControls.children = [headerLayout, footerLayout]
//        return ASBackgroundLayoutSpec(child: layoutPager, background: stackLayoutControls)
    }
}

class SliderNodeController: ASViewController<SliderNode>, SliderView {
    fileprivate let sliderNode: SliderNode
    fileprivate let viewModel: SliderViewModel

    init(viewModel: SliderViewModel) {
        sliderNode = SliderNode(post: viewModel.post)
        self.viewModel = viewModel
        super.init(node: sliderNode)
        sliderNode.pagerNode.setDataSource(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
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
