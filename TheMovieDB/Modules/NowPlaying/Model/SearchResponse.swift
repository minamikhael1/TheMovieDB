//
//  SearchResponse.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    var movies: [Movie]
    var page: Int
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
    }
}
