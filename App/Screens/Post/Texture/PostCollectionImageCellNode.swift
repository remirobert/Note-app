//
//  PostCollectionImageCellNode.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class PostImageCellNode: ASCellNode {
    private let imageNode = ASImageNode()

    init(image: UIImage) {
        super.init()
        imageNode.image = image
        imageNode.contentMode = .scaleAspectFill
        backgroundColor = UIColor.black
        borderWidth = 1
        borderColor = UIColor.lightGray.cgColor
        cornerRadius = 15
        addSubnode(imageNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}

class PostCollectionImageCellNode: ASCellNode, ASCollectionDataSource, ASCollectionDelegate, PhotoPickerProviderDelegate {
    private let collectionNode: ASCollectionNode
    var images = [UIImage]() {
        didSet {
            collectionNode.reloadData()
        }
    }

    weak var delegate: CellContentUpdateDelegate?

    override init() {
        let collectionViewLayout = VerticalCollectionViewLayout()
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
        super.init()
        selectionStyle = .none
        addSubnode(collectionNode)
        collectionNode.dataSource = self
        collectionNode.delegate = self
        collectionNode.backgroundColor = UIColor.clear
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        collectionNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width / 5 * 2)
        let insets = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        return ASInsetLayoutSpec(insets: insets, child: collectionNode)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let image = images[indexPath.row]
        return {
            PostImageCellNode(image: image)
        }
    }

    func pickedPhoto(images: [UIImage]?) {
        guard let images = images else { return }
        self.images.append(contentsOf: images)
        collectionNode.reloadData()
        delegate?.didUpdateContent()
    }

    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: (collectionNode.frame.size.width - 70) / 5,
                          height: (collectionNode.frame.size.width - 70) / 5)
        return ASSizeRange(min: size, max: size)
    }
}
