//
//  SliderPreviewTransition.swift
//  App
//
//  Created by Remi Robert on 10/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class SliderPreviewTransition {
    let previewImage: UIImage?
    let previewRect: CGRect
    let startIndex: Int

    init(previewImage: UIImage?, previewRect: CGRect, startIndex: Int) {
        self.previewImage = previewImage
        self.previewRect = previewRect
        self.startIndex = startIndex
    }
}
