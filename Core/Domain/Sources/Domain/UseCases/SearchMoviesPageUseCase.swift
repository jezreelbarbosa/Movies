//
//  SearchMoviesPageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 15/11/21.
//

import Foundation
import Common

public protocol SearchMoviesPageUseCaseProtocol {

    func execute(request: SearchMoviesRequest, completion: @escaping DomainResultCompletion<[MovieResponse]>)
}

public class SearchMoviesPageUseCase {

    // Properties

    let repository: MoviesRepository

    // Lifecycle

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
}

extension SearchMoviesPageUseCase: SearchMoviesPageUseCaseProtocol {

    public func execute(request: SearchMoviesRequest, completion: @escaping DomainResultCompletion<[MovieResponse]>) {
        repository.searchMovies(request: request, completion: completion)
    }
}
