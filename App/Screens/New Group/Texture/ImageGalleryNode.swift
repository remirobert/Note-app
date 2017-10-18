

//
//  ImageGalleryNode.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit
import RealmPlatform

protocol ImageGalleryCellNodeDelegate: class {
    func didSelectImage(index: Int, image: UIImage?, rect: CGRect)
}

class ImageGalleryNodeLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        let size = CGFloat(UIScreen.main.bounds.size.width - 100) / 3
        itemSize = CGSize(width: size, height: size)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImageGalleryCellNode: ASCellNode {
    let imageNode = ASImageNode()
    private let operationQueue = OperationQueue()

    init(image: String) {
        super.init()
        addSubnode(imageNode)

        var path = DefaultFileManager.documentUrl
        path?.appendPathComponent(image)
        guard let pathUrl = path else {
            return
        }

        operationQueue.addOperation { [weak self] in
            guard let image = UIImage(contentsOfFile: pathUrl.absoluteString) else { return }
            self?.imageNode.image = image
        }
        imageNode.placeholderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        imageNode.imageModificationBlock = { image in
            return image.round(cornerSize: CGSize(width: 15, height: 15))
        }
        imageNode.contentMode = .scaleAspectFill
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}

class ImageGalleryNode: ASDisplayNode {
    fileprivate let collectionNode = ASCollectionNode(collectionViewLayout: ImageGalleryNodeLayout())
    fileprivate let images: [String]
    let height: CGFloat

    weak var delegate: ImageGalleryCellNodeDelegate?

    init(images: [String], widthTableNode: CGFloat) {
        self.images = images
        if images.count >= 1 && images.count <= 3 {
            height = CGFloat(widthTableNode - 100) / 3
        } else if images.count > 3 && images.count <= 6 {
            height = CGFloat(widthTableNode - 100) / 3 * 2 + 10
        } else {
            height = 0
        }
        super.init()
        setupHierarchy()
        setupNodes()
    }

    override func didLoad() {
        super.didLoad()
        collectionNode.view.isScrollEnabled = false
    }
}

extension ImageGalleryNode {
    fileprivate func setupHierarchy() {
        addSubnode(collectionNode)
    }

    fileprivate func setupNodes() {
        collectionNode.dataSource = self
        collectionNode.delegate = self
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: collectionNode)
    }
}

extension ImageGalleryNode: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let image = images[indexPath.row]
        return {
            ImageGalleryCellNode(image: image)
        }
    }
}

extension ImageGalleryNode: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: (collectionNode.calculatedSize.width - 20) / 3,
                          height: (collectionNode.calculatedSize.width - 20) / 3)
        return ASSizeRange(min: size, max: size)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        guard let node = collectionNode.nodeForItem(at: indexPath) as? ImageGalleryCellNode else { return }
        let rect = node.convert(node.frame, to: nil)
        self.delegate?.didSelectImage(index: indexPath.row, image: node.imageNode.image, rect: rect)
    }
}
