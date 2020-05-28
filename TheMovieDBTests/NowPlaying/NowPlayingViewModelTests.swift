//
//  NowPlayingViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Mina Mikhael on 28.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
import XCTest
@testable import TheMovieDB

class RepositoriesListViewModelTests: XCTestCase {

    func testSuccessFetchNowPlaying() {
        let apiClient = MockAPIClient()
        let viewModel = NowPlayingViewModel(apiClient: apiClient)
        viewModel.fetchNowPlaying()
        guard case FetchingServiceState.finishedLoading = viewModel.state.value else {
            XCTFail()
            return
        }
    }

    func testFailFetchNowPlaying() {
        let apiClient = MockAPIClient()
        apiClient.mockNowPlayingResponse = .failure(NetworkError.unknown)
        let viewModel = NowPlayingViewModel(apiClient: apiClient)
        viewModel.fetchNowPlaying()
        guard case FetchingServiceState.error(_) = viewModel.state.value else {
            XCTFail()
            return
        }
    }
}

class MockAPIClient: APIClient {
    
    var mockNowPlayingResponse: APIResponse<NowPlayingResponse> = .success(NowPlayingResponse.getMockNowPlayingResponse())

    override func getNowPlayingMovies(service: Service, completion: @escaping (APIResponse<NowPlayingResponse>) -> ()) {
        return completion(mockNowPlayingResponse)
    }
}
