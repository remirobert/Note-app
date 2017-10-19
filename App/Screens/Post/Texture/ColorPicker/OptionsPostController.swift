//
//  OptionPostController.swift
//  App
//
//  Created by Remi Robert on 19/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import AsyncDisplayKit

class ColorPickerPostCellNode: ASCellNode {
    private let colorNode = ASDisplayNode()
    
    init(color: UIColor) {
        super.init()
        colorNode.borderColor = UIColor.lightGray.cgColor
        colorNode.borderWidth = 1
        colorNode.backgroundColor = color
        addSubnode(colorNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        colorNode.cornerRadius = (constrainedSize.max.width - 20) / 2
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return ASInsetLayoutSpec(insets: insets, child: colorNode)
    }
}

class ColorPickerPostController: ASViewController<ASCollectionNode> {
    private let collectionNode: ASCollectionNode
    fileprivate let colors = AppColors.postColors
    
    var completionColor: ((UIColor) -> Void)?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(node: collectionNode)
        collectionNode.dataSource = self
        collectionNode.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorPickerPostController: ASCollectionDataSource, ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let color = colors[indexPath.row]
        return {
            ColorPickerPostCellNode(color: color)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: 60, height: 60)
        return ASSizeRange(min: size, max: size)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        completionColor?(color)
    }
}
