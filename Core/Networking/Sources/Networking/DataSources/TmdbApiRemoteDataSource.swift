//
//  TmdbApiRemoteDataSource.swift
//  Networking
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import AppData
import Common

public class TmdbApiRemoteDataSource {

    // Properties

    var searchTask: URLSessionDataTask?
    let dispatcher = Dispatcher()

    // Lifecycle

    public init() {}
}

extension TmdbApiRemoteDataSource: AppData.TmdbApiRemoteDataSource {

    public func getPopularMovies(request: MovieURLRequestDTO, completion: @escaping DataResultCompletion) {
        dispatcher.call(endpoint: TmdbApiTargets.popular(request)) { result in
            result.successHandler { data, _ in
                completion(.success(data))
            }
            result.failureHandler { error in
                completion(.failure(error.asDTO))
            }
        }
    }

    public func getSearchMovies(request: SearchMovieRequestDTO, completion: @escaping DataResultCompletion) {
        if request.cancelsLastRequest {
            searchTask?.cancel()
        }

        searchTask = dispatcher.call(endpoint: TmdbApiTargets.search(request)) { result in
            result.successHandler { data, _ in
                completion(.success(data))
            }
            result.failureHandler { error in
                completion(.failure(error.asDTO))
            }
        }

        guard let searchTask = searchTask else { return }
        URLCache.shared.removeCachedResponse(for: searchTask)
        searchTask.resume()
    }

    public func getPosterImage(path: String, completion: @escaping DataResultCompletion) {
        dispatcher.call(endpoint: TmdbApiTargets.posterImage(path)) { result in
            result.successHandler { data, _ in
                completion(.success(data))
            }
            result.failureHandler { error in
                completion(.failure(error.asDTO))
            }
        }
    }
}
