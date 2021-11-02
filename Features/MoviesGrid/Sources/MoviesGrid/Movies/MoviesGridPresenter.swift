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
import UIKit

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
    var popularPage: Int = 1

    var popularMovies: [MovieGridViewModel] = []
    var popularIndex: Int = 1

    unowned let coordinator: MoviesGridCoordinating
    let popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol
    let getPosterImageUseCase: GetPosterImageUseCaseProtocol

    // Lifecycle

    public init(coordinator: MoviesGridCoordinating,
                popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol,
                getPosterImageUseCase: GetPosterImageUseCaseProtocol) {
        self.coordinator = coordinator
        self.popularMoviesPageUseCase = popularMoviesPageUseCase
        self.getPosterImageUseCase = getPosterImageUseCase
    }

    // Functions

    func updateMovies(movies: [MovieGridViewModel]) {
        for movie in movies {
            let (_, member) = moviesSet.insert(movie)
            member.popularIndex = popularIndex
            popularIndex += 1
            getPosterImage(movie: movie)
        }
        popularMovies = moviesSet.filter({ $0.popularIndex.isNotNil }).sorted(by: { $0.popularIndex < $1.popularIndex })
    }

    func getPosterImage(movie: MovieGridViewModel) {
        guard let path = movie.movie.posterPath else { return }
        weak var weakMovie = movie
        getPosterImageUseCase.execute(path: path) { result in
            guard let data = result.success else { return }
            weakMovie?.posterImage = UIImage(data: data)
            NotificationCenter.default.post(name: MovieGridViewModel.didDownloadPosterImageNN, object: weakMovie)
        }
    }
}

// MARK: - Presenting

extension MoviesGridPresenter: MoviesGridPresenting {

    public func fetchPopularMovies() {
        popularMoviesPageUseCase.execute(page: popularPage, locale: Configs.locale) { [weak self] result in
            guard let self = self else { return }
            result.successHandler { movies in
                self.popularPage += 1
                self.updateMovies(movies: movies.map({ MovieGridViewModel(movie: $0) }))
                self.view.show(movies: self.popularMovies)
            }
            result.failureHandler { error in
                print(error)
            }
        }
    }
}
