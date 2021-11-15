//
//  SearchMoviesPageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 15/11/21.
//

import Foundation
import Common

public enum SearchMoviesPageError: Error {

    case requestError(Error?)
    case jsonError(Error)
    case emptyError
}

public protocol SearchMoviesPageUseCaseProtocol {

    func execute(request: SearchMoviesRequest, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>)
}

public class SearchMoviesPageUseCase {

        // Properties

    let remote: TmdbApiRemoteDataSource

        // Lifecycle

    public init(remote: TmdbApiRemoteDataSource) {
        self.remote = remote
    }
}

extension SearchMoviesPageUseCase: SearchMoviesPageUseCaseProtocol {

    public func execute(request: SearchMoviesRequest, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>) {
        remote.getSearchMovies(request: request, completion: completion)
    }
}
