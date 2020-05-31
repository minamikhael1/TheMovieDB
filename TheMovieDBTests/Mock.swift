//
//  Mock.swift
//  TheMovieDBTests
//
//  Created by Mina Mikhael on 28.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
@testable import TheMovieDB

internal extension Movie {
    static func getMockMovie() -> Movie {
        return Movie(id: 1, title: "Titanic", overview: "Overview text", poster: "1.jpg", voteAverage: 8.7)
    }
}

internal extension NowPlayingResponse {
    static func getMockNowPlayingResponse () -> NowPlayingResponse {
        return NowPlayingResponse(movies: [Movie.getMockMovie()], totalPages: 1)
    }
}
