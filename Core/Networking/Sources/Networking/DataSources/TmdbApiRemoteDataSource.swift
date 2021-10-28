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

    public init() {}
}

extension TmdbApiRemoteDataSource: Domain.TmdbApiRemoteDataSource {

    public func execute(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        let apiKey = "72ee2814ce7d37165e7a836cc8cf9186"
        let string = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=\(locale)&page=\(page)"
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

    private func handle(data: Data, completion: ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            let resultsObject = jsonObject?.value(forKey: "results") ?? NSNull()
            let moviesData = try JSONSerialization.data(withJSONObject: resultsObject)
            let movies = try JSONDecoder().decode([MovieResponse].self, from: moviesData)
            completion(.success(movies))
        } catch let error {
            completion(.failure(.jsonError(error)))
        }
    }
}
