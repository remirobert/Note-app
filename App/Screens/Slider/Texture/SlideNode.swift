//
//  SlideNode.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import Domain

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
    let imageNode = ASImageNode()
    fileprivate let previewTransition: SliderPreviewTransition?

    var transitionState: SliderNodeTransitionState = .displayed
    weak var delegate: SliderNodeTransitionStateDelegate?

    init(post: PostImage, previewTransition: SliderPreviewTransition?) {
        self.previewTransition = previewTransition
        super.init()
        addSubnode(pagerNode)
        setupPreviewImageNode()
        pagerNode.backgroundColor = UIColor.black//.withAlphaComponent(0.1)
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
}

extension SliderNode {
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
            pagerNode.style.preferredSize = constrainedSize.max//UIScreen.main.bounds.size
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

