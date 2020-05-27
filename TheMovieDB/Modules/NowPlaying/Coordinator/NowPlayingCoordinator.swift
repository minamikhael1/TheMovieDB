//
//  NowPlayingCoordinator.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit
import Foundation

class NowPlayingCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var nowPlayingViewModel = NowPlayingViewModel()

    //MARK:- Init
     init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let nowPlayingViewController = NowPlayingViewController(viewModel: nowPlayingViewModel)
        nowPlayingViewModel.delegate = self
        return nowPlayingViewController
    }

    func show(present: Bool = false) {
        let repositoriesListViewController = getViewController()
        if present {
            repositoriesListViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(repositoriesListViewController, animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(repositoriesListViewController, animated: true)
        }
    }
}

//MARK:- RepositoriesListViewModelDelegate
extension NowPlayingCoordinator: NowPlayingViewModelDelegate {
    func nowPlayingDidSelect(movie: Movie) {
        let detailsPageCoordinator = MovieDetailCoordinator(navigationController: self.navigationController, movie: movie)
        detailsPageCoordinator.show()
    }
}
