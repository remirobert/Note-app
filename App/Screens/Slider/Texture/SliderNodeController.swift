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
    private let previewImage: UIImage?
    private let rectImage: CGRect
    private let startIndex: Int

    init(post: PostImage, previewImage: UIImage?, rectImage: CGRect, startIndex: Int) {
        self.post = post
        self.previewImage = previewImage
        self.rectImage = rectImage
        self.startIndex = startIndex
    }

    func make() -> SliderView {
        let viewModel = SliderViewModel(post: post)
        let previewTransition = SliderPreviewTransition(previewImage: previewImage,
                                                        previewRect: rectImage,
                                                        startIndex: startIndex)
        return SliderNodeController(viewModel: viewModel,
                                    previewTransition: previewTransition)
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

enum SliderNodeTransitionState {
    case presenting
    case displayed
    case dismissing
}

protocol SliderNodeTransitionStateDelegate: class {
    func didFinishStateTransition(state: SliderNodeTransitionState)
}

class SliderNode: ASDisplayNode {
    let pagerNode = ASPagerNode(collectionViewLayout: SliderLayout())
    fileprivate let previewTransition: SliderPreviewTransition?
    let imageNode = ASImageNode()

    var transitionState: SliderNodeTransitionState = .presenting
    weak var delegate: SliderNodeTransitionStateDelegate?

    init(post: PostImage, previewTransition: SliderPreviewTransition?) {
        self.previewTransition = previewTransition
        super.init()
        addSubnode(pagerNode)
        setupPreviewImageNode()
        pagerNode.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        backgroundColor = UIColor.clear
    }

    private func setupPreviewImageNode() {
        guard let previewTransition = self.previewTransition,
            let previewImage = previewTransition.previewImage else {
            return
        }
        addSubnode(imageNode)
        imageNode.backgroundColor = UIColor.clear
        imageNode.cornerRadius = 5
        imageNode.image = previewImage
        imageNode.forceUpscaling = true
        imageNode.contentsScale = 1
        let ratioImage = UIScreen.main.bounds.size.width / previewImage.size.width
        let forcedSize = CGSize(width: UIScreen.main.bounds.size.width,
                                height: previewImage.size.height * ratioImage)

        imageNode.forcedSize = forcedSize
        imageNode.contentMode = .scaleAspectFill
        imageNode.style.preferredSize = previewTransition.previewRect.size
        imageNode.style.layoutPosition = previewTransition.previewRect.origin
        imageNode.layer.masksToBounds = true
        imageNode.layoutIfNeeded()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        switch transitionState {
        case .displayed:
            pagerNode.style.flexGrow = 1
            let stackLayout = ASStackLayoutSpec.vertical()
            stackLayout.alignContent = .center
            stackLayout.children = [pagerNode]
            return stackLayout
        case .presenting:
            pagerNode.style.layoutPosition = CGPoint.zero
            pagerNode.style.preferredSize = UIScreen.main.bounds.size
            imageNode.style.preferredSize = self.previewTransition?.previewRect.size ?? CGSize.zero
            imageNode.style.layoutPosition = self.previewTransition?.previewRect.origin ?? CGPoint.zero
            return ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [pagerNode, imageNode])
        case .dismissing:
            pagerNode.isHidden = true
            imageNode.isHidden = false
            return ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [pagerNode, imageNode])
        }
    }

    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        switch transitionState {
        case .displayed:
            guard let image = imageNode.image else { return }
            self.imageNode.frame = self.previewTransition?.previewRect ?? CGRect.zero
            let ratioImage = image.size.height / image.size.width
            let finalSize = CGSize(width: UIScreen.main.bounds.size.width - 20,
                                   height: (UIScreen.main.bounds.size.width - 20) * ratioImage)
            let finalPosition = CGPoint(x: 10, y: (UIScreen.main.bounds.size.height - finalSize.height) / 2)

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.imageNode.frame.size = finalSize
                self.imageNode.frame.origin = finalPosition
                self.backgroundColor = UIColor.black
            }) { _ in
                self.pagerNode.isHidden = false
                self.imageNode.isHidden = true
                context.completeTransition(true)
                self.delegate?.didFinishStateTransition(state: self.transitionState)
            }
        case .presenting:
            context.completeTransition(true)
            self.delegate?.didFinishStateTransition(state: transitionState)
        case .dismissing:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.imageNode.frame = self.previewTransition?.previewRect ?? CGRect.zero
                self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            }) { _ in
                context.completeTransition(true)
                self.delegate?.didFinishStateTransition(state: self.transitionState)
            }
        }
    }
}

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
