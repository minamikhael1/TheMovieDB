//
//  URLComponentExtensions.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

extension URLComponents {
    init(service: Service) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }
        queryItems = []
        for (key, value) in parameters {
            queryItems?.append(URLQueryItem(name: key, value: String(describing: value)))
        }
    }
}
