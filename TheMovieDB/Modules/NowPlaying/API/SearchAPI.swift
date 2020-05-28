//
//  SearchAPI.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 28.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class SearchAPI: Service {

    var paramters: [String: String]?

    init(paramters: [String: String]?) {
        self.paramters = paramters
        self.paramters?.append(dict: NetworkConstants.defaultRequestParams)
    }

    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }

    var path: String {
        return NetworkConstants.searchServicePath
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        return .requestParameters(self.paramters ?? [:])
    }

    var headers: RequestHeaders? {
        return NetworkConstants.defaultRequestHeaders
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

protocol SearchAPIService {
    func searchMovies(service: Service, completion: @escaping (_ result: APIResponse<SearchResponse>) -> ())
}
