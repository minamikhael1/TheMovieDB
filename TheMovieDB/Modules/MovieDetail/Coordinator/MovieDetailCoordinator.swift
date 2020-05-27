//
//  MovieDetailCoordinator.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var movie: Movie

    //MARK:- Init
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = UIColor.black
        self.movie = movie
    }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let viewModel = MovieDetailViewModel(movie: movie)
        return MovieDetailViewController(viewModel: viewModel)
    }

    func show(present: Bool = false) {
        let movieDetailViewController = getViewController()
        if present {
            movieDetailViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(movieDetailViewController, animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(movieDetailViewController, animated: true)
        }
    }
}
