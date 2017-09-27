    //
    //  PostCell.swift
    //  App
    //
    //  Created by Remi Robert on 25/09/2017.
    //  Copyright © 2017 Remi Robert. All rights reserved.
    //

    import UIKit
    import Domain
    import SnapKit

    class PostCellViewModel: CellViewModel {
        private let post: PostImage
        var reuseIdentifier = String(describing: PostCell.self)

        var title: String { return post.titlePost}
        var descriptionPost: String { return post.descriptionPost }
        var imagesUrl: [String] {
            return post.images.map { $0 }
        }

        init(post: PostImage) {
            self.post = post
        }

        func contentSize() -> CGSize {
            let heightTitle = post.titlePost.size(textAttributes: TextAttributes.postCreationTitle).height
            let heightDescription = post.descriptionPost.size(textAttributes: TextAttributes.postCreationContent).height
            let heightCell = heightTitle + heightDescription + GalleryViewComponent.heightComponent(imagesCount: post.images.count)
            return CGSize(width: UIScreen.main.bounds.size.width, height: heightCell)
        }
    }

    class PostCell: UICollectionViewCell, CellType {
        fileprivate let title = TextViewComponent(textAttributes: TextAttributes.postCreationTitle)
        fileprivate let content = TextViewComponent(textAttributes: TextAttributes.postCreationContent)
        fileprivate let gallery = GalleryViewComponent()
        fileprivate var heightGalleryConstraint: Constraint?

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            setupHierarchy()
            setupLayout()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func bind(cellData: CellViewModel) {
            guard let viewModel = cellData as? PostCellViewModel else { return }
            title.bind(string: viewModel.title)
            content.bind(string: viewModel.descriptionPost)
            gallery.bind(imagesUrl: viewModel.imagesUrl)
            let newGalleryHeight = GalleryViewComponent.heightComponent(imagesCount: viewModel.imagesUrl.count)
            heightGalleryConstraint?.update(offset: newGalleryHeight)
        }
    }

    extension PostCell {
        fileprivate func setupHierarchy() {
            contentView.addSubview(title)
            contentView.addSubview(gallery)
            contentView.addSubview(content)
        }

        fileprivate func setupLayout() {
            title.snp.makeConstraints { make in
                make.top.right.left.equalToSuperview()
            }
            gallery.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom)
                make.left.right.equalToSuperview()
                heightGalleryConstraint = make.height.equalTo(0).constraint
            }
            content.snp.makeConstraints { make in
                make.top.equalTo(gallery.snp.bottom)
                make.right.left.bottom.equalToSuperview()
            }
        }

        fileprivate func setupViews() {
            gallery.backgroundColor = UIColor.white
        }
    }
