//
//  NowPlayingCoordinator.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit
import Foundation

protocol NowPlayingCoordinatorDelegate {
    func movieSelected(movie: Movie)
}

class NowPlayingCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var nowPlayingViewModel = NowPlayingViewModel()
    var searchViewModel = SearchViewModel()
    var delegate: NowPlayingCoordinatorDelegate?

    //MARK:- Init
     init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let viewController = NowPlayingViewController(viewModel: nowPlayingViewModel, searchViewModel: searchViewModel)
        viewController.coordinatorDelegate = self
        return viewController
    }

    func show(present: Bool = false) {
        let nowPlayingViewController = getViewController()
        if present {
            nowPlayingViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(nowPlayingViewController, animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(nowPlayingViewController, animated: true)
        }
    }
}

extension NowPlayingCoordinator: NowPlayingCoordinatorDelegate {
    func movieSelected(movie: Movie) {
        MovieDetailCoordinator(navigationController: self.navigationController, movie: movie).show()
    }
}
