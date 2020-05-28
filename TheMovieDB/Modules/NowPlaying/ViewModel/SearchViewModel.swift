//
//  SearchViewModel.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 28.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    //MARK:- Properties
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    private let apiClient: APIClient
    private (set) var searchResult: Bindable<[Movie]> = Bindable([])
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max

    //MARK:- init
    //init SearchViewModel with dependency injection of network server client object
    //to be able to mock the network layer for unit testing
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    //MARK:- Helpers
    func search(query: String) {
        if currentPage > totalPages { return }
        state.value = .loading
        let parameters = ["query": query, "page": "\(currentPage)"]
        apiClient.searchMovies(service: SearchAPI(paramters: parameters), completion: { [weak self] response in
            self?.state.value = .finishedLoading
            switch response {
            case .success(let result):
                self?.searchResult.value.append(contentsOf: result.movies)
                self?.totalPages = result.totalPages
                self?.currentPage += 1
            case .failure(let error):
                self?.state.value = .error(error)
            }
        })
    }

    func resetSearch() {
        currentPage = 1
        totalPages = Int.max
        searchResult.value.removeAll()
    }
}
