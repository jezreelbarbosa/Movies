//
//  MoviesRepository.swift
//  AppData
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common
import Domain

public class MoviesRepository {

    // Properties

    let remote: TmdbApiRemoteDataSource
    let local: MoviesLocalDataSource

    // Lifecycle

    public init(remote: TmdbApiRemoteDataSource, local: MoviesLocalDataSource) {
        self.remote = remote
        self.local = local
    }
}

extension MoviesRepository: Domain.MoviesRepository {

    public func popularMovies(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], DomainError>) {
        guard let apiKey = local.getApiKey() else {
            completion(.failure(.appDataError(.storageError)))
            return
        }
        let request = MovieURLRequestDTO(apiKey: apiKey, locale: locale, page: String(page))
        remote.getPopularMovies(request: request) { [weak self] result in
            result.successHandler { data in
                self?.handle(data: data, completion: completion)
            }
            result.failureHandler { error in
                completion(.failure(error.domainError))
            }
        }
    }

    public func searchMovies(request: SearchMoviesRequest, completion: @escaping ResultCompletion<[MovieResponse], DomainError>) {
        guard let apiKey = local.getApiKey() else {
            completion(.failure(.appDataError(.storageError)))
            return
        }
        let request = SearchMovieRequestDTO(apiKey: apiKey, query: request.query, locale: request.locale,
                                            page: request.page, cancelsLastRequest: request.cancelsLastRequest)
        remote.getSearchMovies(request: request) { [weak self] result in
            result.successHandler { data in
                self?.handle(data: data, completion: completion)
            }
            result.failureHandler { error in
                completion(.failure(error.domainError))
            }
        }
    }

    public func posterImage(path: String, completion: @escaping ResultCompletion<Data, DomainError>) {
        remote.getPosterImage(path: path) { result in
            result.successHandler { data in
                completion(.success(data))
            }
            result.failureHandler { error in
                completion(.failure(error.domainError))
            }
        }
    }

    private func handle(data: Data, completion: ResultCompletion<[MovieResponse], DomainError>) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            guard let resultsObject = jsonObject?.value(forKey: "results") else { throw AppDataError.decoderError }
            let moviesData = try JSONSerialization.data(withJSONObject: resultsObject)
            let movies = try JSONDecoder().decode([MovieResponse].self, from: moviesData)

            completion(.success(movies))
        } catch let error {
            debugPrint(error)
            completion(.failure(.appDataError(.decoderError)))
        }
    }
}
