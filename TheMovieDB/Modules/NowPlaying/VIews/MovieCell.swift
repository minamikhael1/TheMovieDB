//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    static let cellIdentifier = String(describing: MovieCell.self)
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movie: Movie? {
        didSet {
            titleLabel.text = movie?.title
            overviewLabel.text = movie?.overview
            if let moviePoster = movie?.posterUrl() {
                posterImage.kf.setImage(with: moviePoster, placeholder: UIImage(named: "placeholder"))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = posterImage.frame.width / 2
    }
}
