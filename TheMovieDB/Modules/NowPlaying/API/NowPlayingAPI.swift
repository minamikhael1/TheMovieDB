//
//  NowPlayingAPI.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class NowPlayingAPI: Service {

    var paramters: [String: String]?

    init(paramters: [String: String]?) {
        self.paramters = paramters
        self.paramters?["api_key"] = "04c56a8a469a987ce3cf341217ff9664"
    }

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        return "/movie/now_playing"
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

protocol NowPlayingAPIService {
    func getNowPlayingMovies(service: Service, completion: @escaping (_ result: NetworkServiceResponse<NowPlayingResponse>) -> ())
}
