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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //MARK:- Variables
    var movie: Movie?

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
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
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        ratingLabel.text = "\(movie.rating)"
        if let moviePoster = movie.posterUrl() {
            posterImage.kf.setImage(with: moviePoster, placeholder: UIImage(named: "placeholder"))
        }
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
