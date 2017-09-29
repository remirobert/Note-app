

//
//  ImageGalleryNode.swift
//  App
//
//  Created by Remi Robert on 29/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class ImageGalleryNodeLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        let size = CGFloat(UIScreen.main.bounds.size.width - 100) / 3
        print("size : \(size) : 335 : \(UIScreen.main.bounds.size.width - 40)")
        itemSize = CGSize(width: size, height: size)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImageGalleryCellNode: ASCellNode {
    private let imageNode = ASImageNode()
    init(image: UIImage) {
        super.init()
        addSubnode(imageNode)
        imageNode.image = image
        imageNode.placeholderColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        imageNode.imageModificationBlock = { image in
            return image.round(cornerSize: CGSize(width: 15, height: 15))
        }
        imageNode.contentMode = .scaleAspectFill
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
        //return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), child: imageNode)
    }
}

class ImageGalleryNode: ASDisplayNode {
    fileprivate let collectionNode = ASCollectionNode(collectionViewLayout: ImageGalleryNodeLayout())
    fileprivate let images: [UIImage]
    let height: CGFloat

    init(images: [UIImage]) {
        self.images = images
        height = CGFloat(UIScreen.main.bounds.size.width - 100) / 3 * 2 + 10
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
