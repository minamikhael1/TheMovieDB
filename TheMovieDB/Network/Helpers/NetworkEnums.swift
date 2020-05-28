//
//  NetworkEnums.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters([String: String])
}

enum ParametersEncoding {
    case url
    case json
}

enum NetworkServiceResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case unauthorized
    case unknown
    case noJSONData
    case JSONDecoder
}
