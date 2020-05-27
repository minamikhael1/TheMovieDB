//
//  NowPlayingViewModel.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

enum FetchingServiceState: Equatable {
    case loading
    case finishedLoading
    case error(NetworkError?)
}

protocol NowPlayingViewModelDelegate {
    func nowPlayingDidSelect(movie: Movie)
}

class NowPlayingViewModel {

    //MARK:- Properties
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    private let apiClient: APIClient
    private var searchResponse: SearchResponse?
    private (set) var nowPlayingList: Bindable<[Movie]> = Bindable([])
    var delegate: NowPlayingViewModelDelegate?
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max

    //MARK:- init
    //init NowPlayingViewModel with dependency injection of network server client object
    //to be able to mock the network layer for unit testing
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    //MARK:- Helpers
    func fetchNowPlaying() {
        if currentPage > totalPages { return }
        state.value = .loading
        apiClient.getNowPlayingMovies(service: NowPlayingAPI(paramters: ["page": "\(currentPage)"]), completion: { [weak self] response in
            self?.state.value = .finishedLoading
            switch response {
            case .success(let result):
                self?.nowPlayingList.value.append(contentsOf: result.movies)
                self?.totalPages = result.totalPages
                self?.currentPage += 1
            case .failure(let error):
                self?.state.value = .error(error)
            }
        })
    }

//    func didSelectItemAt(index: Int) {
//        if let movie = searchResponse?.repositories[index] {
//            self.delegate?.repositoriesListViewModelDidSelect(repository: repository)
//        }
//    }
//
//    func update(repository: Repository) {
//        if let searchReposnse = self.searchResponse, let index = self.searchResponse?.repositories.firstIndex(where: {$0.id == repository.id}) {
//            self.searchResponse?.repositories[index] = repository
//            self.repositoriesCellsViewModels.value = searchReposnse.repositories.compactMap { RepositoryCellViewModel(repository: $0)}
//        }
//    }
}

