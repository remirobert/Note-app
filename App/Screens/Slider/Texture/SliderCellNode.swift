//
//  SliderCellNode.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import RealmPlatform
import Domain

class SliderCellNode: ASCellNode {
    private let operationQueue = OperationQueue()
    private let imageNode = ASImageNode()

    init(image: String) {
        super.init()
        addSubnode(imageNode)
        imageNode.contentMode = .scaleAspectFit
        backgroundColor = UIColor.white

        var path = DefaultFileManager.documentUrl
        path?.appendPathComponent(image)
        guard let pathUrl = path else {
            return
        }
        operationQueue.addOperation { [weak self] in
            guard let image = UIImage(contentsOfFile: pathUrl.absoluteString) else { return }
            self?.imageNode.image = image
        }
        imageNode.imageModificationBlock = { image in
            return image.round(cornerSize: CGSize(width: 15, height: 15))
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return ASInsetLayoutSpec(insets: insets, child: imageNode)
    }
}
