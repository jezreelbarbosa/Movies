//
//  PopularMoviesPageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common

public enum PopularMoviesPageError: Error {

    case requestError(Error?)
    case jsonError(Error)
    case emptyError
}

public protocol PopularMoviesPageUseCaseProtocol {

    func execute(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>)
}

public class PopularMoviesPageUseCase {

    // Properties

    let remote: TmdbApiRemoteDataSource

    // Lifecycle

    public init(remote: TmdbApiRemoteDataSource) {
        self.remote = remote
    }
}

extension PopularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol {

    public func execute(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        remote.getPopularMovies(page: page, locale: locale, completion: completion)
    }
}
