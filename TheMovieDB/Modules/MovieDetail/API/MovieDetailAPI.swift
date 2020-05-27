//
//  MovieDetailAPI.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation
class MovieDetailAPI: Service {

    var paramters: [String: String]?

    init(paramters: [String: String]?) {
        self.paramters = paramters
    }

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        return "/search/repositories"
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        return .requestParameters(self.paramters ?? [:])
    }

    var headers: RequestHeaders? {
        return nil
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

protocol MovieDetailAPIService {
    func getMovieDetails(service: Service, completion: @escaping (_ result: NetworkServiceResponse<Movie>) -> ())
}
