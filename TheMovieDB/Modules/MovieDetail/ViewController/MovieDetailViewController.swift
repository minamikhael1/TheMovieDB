//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //MARK:- IBOutlet

    //MARK:- Variables
    var movie: Movie?

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    init(movie: Movie) {
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: nil)
        self.movie = movie
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Helpers
    func setupView() {
    }

    //MARK:- Data binding
    private func bindViewModel() {
//        viewModel?.repository.bindAndFire { [weak self] repository in
//            DispatchQueue.main.async {
//                if let imageURL = repository?.owner.avatarUrl,
//                    let url = URL(string: imageURL),
//                    let imageView = self?.ownerImageView {
//                    let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
//                    Nuke.loadImage(with: url, options: options, into: imageView)
//                }
//                self?.repoNameLabel.text = repository?.name
//                self?.repoDescriptionLabel.text = repository?.description
//                self?.starCountsLabel.text = "\(repository?.stargazersCount ?? 0)"
//                self?.forksCountLabel.text = "\(repository?.forksCount ?? 0)"
//            }
//        }
    }
}
