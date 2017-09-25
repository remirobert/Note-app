//
//  CustomCollectionView.swift
//  App
//
//  Created by Remi Robert on 15/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {
    let collectionView: UICollectionView
    var sections = [Section]() {
        didSet {
            collectionView.reloadData()
        }
    }

    var selectionHandler: ((IndexPath, CellViewModel) -> Void)?

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension CollectionDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.section].models[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier,
                                                            for: indexPath)
            as? CellType & UICollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        var reuseIdentifier: String?
        switch kind {
        case UICollectionElementKindSectionHeader:
            reuseIdentifier = section.header?.reuseIdentifier
        case UICollectionElementKindSectionFooter:
            reuseIdentifier = section.footer?.reuseIdentifier
        default:
            break
        }
        guard let identifier = reuseIdentifier else {
            return UICollectionReusableView(frame: CGRect.zero)
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: identifier,
                                                               for: indexPath) as? SupplementaryCellType & UICollectionReusableView ?? UICollectionReusableView(frame: CGRect.zero)
    }
}

extension CollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CellType else { return }
        let model = sections[indexPath.section].models[indexPath.row]
        cell.bind(cellData: model)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        guard let supplementaryView = view as? SupplementaryCellType else { return }
        let section = sections[indexPath.section]
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            if let header = section.header {
                supplementaryView.bind(cellData: header)
            }
        case UICollectionElementKindSectionFooter:
            if let footer = section.footer {
                supplementaryView.bind(cellData: footer)
            }
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = sections[indexPath.section].models[indexPath.row]
        selectionHandler?(indexPath, model)
    }
}

extension CollectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = sections[indexPath.section].models[indexPath.row]
        return model.contentSize()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = sections[section]
        return section.header?.contentSize() ?? CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let section = sections[section]
        return section.footer?.contentSize() ?? CGSize.zero
    }
}
