//
//  DayFeedCoordinator.swift
//  App
//
//  Created by Remi Robert on 17/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Wireframe
import Domain
import RealmPlatform

class DayFeedCoordinator {
    fileprivate let dependencies: Dependencies
    fileprivate let dayFeedView: DayFeedView
    fileprivate let navigationDayFeed: NavigationView
    fileprivate var postCoordinator: PostCoordinator?
    fileprivate var sliderCoordinator: SliderCoordinator!

    struct Dependencies {
        let day: Day
        let parentView: View
        let dayFeedFactory: DayFeedViewFactory
        let dayNavigationFactory: NavigationViewFactory
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.dayFeedView = dependencies.dayFeedFactory.make()
        self.navigationDayFeed = dependencies.dayNavigationFactory.make(rootView: dayFeedView)
    }

    func start() {
        dayFeedView.delegate = self
        self.dependencies.parentView.present(view: self.navigationDayFeed, animated: true)
    }
}

extension DayFeedCoordinator: DayFeedViewDelegate {
    func displaySlider(post: Post, index: Int, image: UIImage?, rect: CGRect) {
        sliderCoordinator = SliderCoordinator(post: post,
                                              parentView: dayFeedView,
                                              previewImage: image,
                                              rectImage: rect,
                                              startIndex: index)
        sliderCoordinator.start()
    }

    func displayCalendarView() {
        navigationDayFeed.dismiss(animated: true)
    }

    func addPost() {
        self.postCoordinator = nil
        let postCoordinator = PostCoordinator(day: dependencies.day,
                                          parentView: dayFeedView)
        postCoordinator.start()
        self.postCoordinator = postCoordinator
    }

    func updatePost(post: Post) {
        self.postCoordinator = nil
        let postCoordinator = PostCoordinator(day: dependencies.day,
                                              parentView: dayFeedView)
        postCoordinator.start()
        self.postCoordinator = postCoordinator
    }
}
