//
//  Movie.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

struct Movie: Codable {

    var id: Int
    var title: String?
    var overview: String?
    var poster: String?
    private var voteAverage: Decimal
    var rating: NSDecimalNumber {
        get { return NSDecimalNumber(decimal: voteAverage) }
    }

    init(id: Int, title: String, overview: String, poster: String, voteAverage: Decimal) {
        self.id = id
        self.title = title
        self.overview = overview
        self.poster = poster
        self.voteAverage = voteAverage
    }

    func posterUrl() -> URL? {
        return URL(string: "\(NetworkConstants.imagesBaseURL)\(poster ?? "")")
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case poster = "poster_path"
        case voteAverage = "vote_average"
    }
}
