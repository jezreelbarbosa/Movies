//
//  TmdbApiRemoteDataSource.swift
//  Networking
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common
import Domain

public class TmdbApiRemoteDataSource {

    // Properties

    var searchTask: URLSessionDataTask?

    // Lifecycle

    public init() {}
}

extension TmdbApiRemoteDataSource: Domain.TmdbApiRemoteDataSource {

    public func getPopularMovies(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let apiKey = "72ee2814ce7d37165e7a836cc8cf9186"
        let baseURL = "https://api.themoviedb.org/"
        let searchURL = "3/movie/popular?api_key=\(apiKey)&language=\(locale)&page=\(page)"
        let string = (baseURL + searchURL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).default

        guard let url = URL(string: string) else { return }
        let task = session.dataTask(with: url) { [self] data, _, error in
            guard let data = data, error == nil
            else {
                completion(.failure(.requestError(error)))
                return
            }
            handle(data: data, completion: completion)
        }
        URLCache.shared.removeCachedResponse(for: task)
        task.resume()
    }

    public func getSearchMovies(request: SearchMoviesRequest, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        if request.cancelsLastRequest {
            searchTask?.cancel()
        }
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let apiKey = "72ee2814ce7d37165e7a836cc8cf9186"
        let baseURL = "https://api.themoviedb.org/"
        let searchURL = "3/search/movie?api_key=\(apiKey)&language=\(request.locale)&query=\(request.query)&page=\(request.page)"
        let string = (baseURL + searchURL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).default

        guard let url = URL(string: string) else { return }
        searchTask = session.dataTask(with: url) { [self] data, _, error in
            guard let data = data, error == nil
            else {
                completion(.failure(.requestError(error)))
                return
            }
            handle(data: data, completion: completion)
        }

        guard let searchTask = searchTask else { return }
        URLCache.shared.removeCachedResponse(for: searchTask)
        searchTask.resume()
    }

    private func handle(data: Data, completion: ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            let resultsObject = jsonObject?.value(forKey: "results") ?? NSNull()
            let moviesData = try JSONSerialization.data(withJSONObject: resultsObject)
            let movies = try JSONDecoder().decode([MovieResponse].self, from: moviesData)

            if movies.isEmpty {
                completion(.failure(.emptyError))
                return
            }
            completion(.success(movies))
        } catch let error {
            completion(.failure(.jsonError(error)))
        }
    }

    public func getPosterImage(path: String, completion: @escaping ResultCompletion<Data, GetPosterImageError>) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342" + path) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestError(error)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
