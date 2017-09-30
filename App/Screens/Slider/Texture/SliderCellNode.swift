//
//  SliderCellNode.swift
//  App
//
//  Created by Remi Robert on 30/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import RealmPlatform

class SliderCellNode: ASCellNode {
    private let operationQueue = OperationQueue()
    private let imageNode = ASImageNode()

    init(image: String) {
        super.init()
        addSubnode(imageNode)
        imageNode.contentMode = .scaleAspectFit
        backgroundColor = UIColor.black

        var path = DefaultFileManager.documentUrl
        path?.appendPathComponent(image)
        guard let pathUrl = path else {
            return
        }

        operationQueue.addOperation { [weak self] in
            guard let image = UIImage(contentsOfFile: pathUrl.absoluteString) else { return }
            self?.imageNode.image = image
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}
