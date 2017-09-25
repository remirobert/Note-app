//
//  DayFeedViewModel.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation
import Domain

class DayFeedViewModel {
    private(set) var section = [Section]()
    private let allPostUseCase: AllPostUseCase
    let day: Day

    init(day: Day, allPostUseCase: AllPostUseCase) {
        self.day = day
        self.allPostUseCase = allPostUseCase
        reloadSections()
    }

    func reloadSections() {
        let datas = allPostUseCase.get()
        print("get datas : \(datas.count)")
        let models = (0...5).map { _ in
            return PostCellViewModel(post: PostImage(images: [UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))!, UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))!, UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))!, UIImagePNGRepresentation(#imageLiteral(resourceName: "image"))! ], titlePost: "Ladybug", descriptionPost: "Ladybug makes it easy to write a model or data-model layer in Swift 4. Full Codable conformance without the headache."))
        }
//        let models = datas.map { (post: Post) -> CellViewModel? in
//            if let image = post as? PostImage {
//                return ImagePostCellViewModel(imageData: image.images.first!)
//            }
//            if let text = post as? PostText {
//                return TextPostCellViewModel(text: text.text)
//            }
//            return nil
//            }.flatMap { $0 }
        section = [Section(models: models, header: nil)]
    }
}
