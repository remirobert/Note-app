//
//  DayFeedCoordinatorNew.swift
//  App
//
//  Created by Remi Robert on 17/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain
import RealmPlatform

class DayFeedCoordinatorNew {
    fileprivate var currentDay: Day!
    fileprivate let subscriber: PostUpdateSubscriber
    fileprivate var postCoordinator: PostCoordinator!
    fileprivate var sliderCoordinator: SliderCoordinator!
    let feedView: DayFeedView
    let navigationView: NavigationView

    init(subscriber: PostUpdateSubscriber) {
        self.subscriber = subscriber
        let viewFactory = DayTextureControllerFactory()
        feedView = viewFactory.make()
        let navigationViewFactory = DayFeedNavigationViewFactory()
        navigationView = navigationViewFactory.make(rootView: feedView)
    }

    func loadDay(day: Day) {
        self.currentDay = day
        let fetchOperation = RMFetchPostOperationFactory(day: day)
        let viewModel = DayTextureViewModel(day: day,
                                            postsOperationProvider: fetchOperation,
                                            subscriber: subscriber)
        feedView.viewModel = viewModel
        feedView.delegate = self
    }
}

extension DayFeedCoordinatorNew: DayFeedViewDelegate {
    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect) {
        sliderCoordinator = SliderCoordinator(post: post,
                                              parentView: feedView,
                                              previewImage: image,
                                              rectImage: rect,
                                              startIndex: index)
        sliderCoordinator.start()
    }

    func displayCalendarView() {

    }

    func addPost() {
        postCoordinator = PostCoordinator(day: currentDay,
                                          parentView: feedView)
        postCoordinator.start()
    }

    func updatePost(post: Post) {
        postCoordinator = PostCoordinator(day: currentDay,
                                          parentView: feedView,
                                          postUpdate: post)
        postCoordinator.start()
    }
}
