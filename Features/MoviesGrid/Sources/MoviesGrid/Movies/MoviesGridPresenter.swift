//
//  MoviesGridPresenter.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import Domain
import UIComponents
import Common

// MARK: - Protocols

public protocol MoviesGridViewable: AnyObject {

    func show(movies: [MovieGridViewModel])
}

public protocol MoviesGridCoordinating: AnyObject {

}

// MARK: - Presenter

public class MoviesGridPresenter<T>: CodePresenter<T> where T: MoviesGridViewable {

    // Properties

    var moviesSet: Set<MovieGridViewModel> = []

    var popularMovies: [MovieGridViewModel] = []
    var popularIndex: Int = 1

    unowned let coordinator: MoviesGridCoordinating
    let popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol

    // Lifecycle

    public init(coordinator: MoviesGridCoordinating, popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol) {
        self.coordinator = coordinator
        self.popularMoviesPageUseCase = popularMoviesPageUseCase
    }

    // Functions

    func updateMovies(movies: [MovieGridViewModel]) {
        for movie in movies {
            let (_, member) = moviesSet.insert(movie)
            if member.popularIndex.isNil {
                member.popularIndex = popularIndex
                popularIndex += 1
            }
        }
        popularMovies = moviesSet.filter({ $0.popularIndex.isNotNil }).sorted(by: { $0.popularIndex < $1.popularIndex })
    }
}

// MARK: - Presenting

extension MoviesGridPresenter: MoviesGridPresenting {

    public func fetchPopularMovies() {
        popularMoviesPageUseCase.execute(page: 1, locale: Configs.locale) { [weak self] result in
            guard let self = self else { return }
            result.successHandler { movies in
                self.updateMovies(movies: movies.map({ MovieGridViewModel(movie: $0) }))
                self.view.show(movies: self.popularMovies)
            }
            result.failureHandler { error in
                print(error)
            }
        }
    }
}
