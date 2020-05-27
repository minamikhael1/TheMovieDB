//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nowPlayingCoordinator: NowPlayingCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        nowPlayingCoordinator = NowPlayingCoordinator(navigationController: UINavigationController())
        nowPlayingCoordinator?.show()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nowPlayingCoordinator?.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
