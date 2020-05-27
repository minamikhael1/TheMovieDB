//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    //MARK:- Properties
    var movie: Bindable<Movie?>

    //MARK:- init
    //init RepositoriesListViewModel with dependency injection of network server client object
    //to be able to mock the network layer for unit testing
    init(/*networkServerClient: NetworkServerClient = NetworkServerClient(),*/ movie: Movie) {
        //self.networkServerClient = networkServerClient
        self.movie = Bindable(movie)
    }
}
