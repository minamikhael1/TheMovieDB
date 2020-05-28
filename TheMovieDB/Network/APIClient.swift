//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import Foundation

class APIClient: NowPlayingAPIService, MovieDetailAPIService {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /**
     Call this method to perfom a web service of type `Service`
     - Parameter type: is generic type should be a model that confirm to `Codable` protocol
     - Parameter completion: result of type `NetworkResponse`.
     */
    private func request<T>(type: T.Type, service: Service, completion: @escaping (NetworkServiceResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: {[weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkServiceResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        switch response.statusCode {
        case 200...299:
            guard let data = data else { return completion(.failure(.JSONDecoder)) }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch (let error) {
                print(error)
                completion(.failure(.unknown))
            }
        default:
            completion(.failure(.unknown))
        }
    }

    //MARK:- Services
    func getNowPlayingMovies(service: Service, completion: @escaping (NetworkServiceResponse<NowPlayingResponse>) -> ()) {
        self.request(type: NowPlayingResponse.self, service: service, completion: completion)
    }

    func getMovieDetails(service: Service, completion: @escaping (NetworkServiceResponse<Movie>) -> ()) {
        self.request(type: Movie.self, service: service, completion: completion)
    }
}
