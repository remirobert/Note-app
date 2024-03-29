//
//  DayFeedView.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain

protocol DayFeedViewDelegate: class {
    func displayCalendarView()
    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect)
    func addPost()
    func updatePost(post: Post)
}

protocol DayFeedViewFactory {
    func make() -> DayFeedView
}

protocol DayFeedView: View {
    weak var delegate: DayFeedViewDelegate? { get set }
    var viewModel: DayTextureViewModel? { get set }
    func reload()
}
