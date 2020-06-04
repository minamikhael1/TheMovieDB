//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class APIClient: NowPlayingAPIService, SearchAPIService {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /**
     Call this method to perfom a web service of type `Service`
     - Parameter type: is generic type should be a model that confirm to `Codable` protocol
     - Parameter completion: result of type `APIResponse`.
     */
    private func request<T>(type: T.Type, service: Service, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: {[weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (APIResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response, let data = data else { return completion(.failure(.noJSONData)) }
        switch response.statusCode {
        case 200...299:
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch (_) {
                completion(.failure(.JSONDecoder))
            }
        case 401:
            completion(.failure(.unauthorized))
        default:
            completion(.failure(.unknown))
        }
    }

    //MARK:- Services
    func getNowPlayingMovies(service: Service, completion: @escaping (APIResponse<NowPlayingResponse>) -> ()) {
        self.request(type: NowPlayingResponse.self, service: service, completion: completion)
    }

    func searchMovies(service: Service, completion: @escaping (APIResponse<SearchResponse>) -> ()) {
        self.request(type: SearchResponse.self, service: service, completion: completion)
    }
}
