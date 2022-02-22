//
//  PopularMoviesPageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common

public protocol PopularMoviesPageUseCaseProtocol {

    func execute(page: Int, locale: String, completion: @escaping DomainResultCompletion<[MovieResponse]>)
}

public class PopularMoviesPageUseCase {

    // Properties

    let repository: MoviesRepository

    // Lifecycle

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
}

extension PopularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol {

    public func execute(page: Int, locale: String, completion: @escaping DomainResultCompletion<[MovieResponse]>) {
        repository.popularMovies(page: page, locale: locale, completion: completion)
    }
}
