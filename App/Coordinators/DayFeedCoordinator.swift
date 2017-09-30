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
    fileprivate var postCoordinator: PostCoordinator!

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
        self.dependencies.parentView.present(view: self.navigationDayFeed)
    }
}

extension DayFeedCoordinator: DayFeedViewDelegate {
    func displaySlider(post: PostImage) {

    }
    
    func displayCalendarView() {
        navigationDayFeed.dismiss()
    }

    func addPost() {
        postCoordinator = PostCoordinator(day: dependencies.day,
                                          parentView: dayFeedView)
        postCoordinator.start()
    }
}
