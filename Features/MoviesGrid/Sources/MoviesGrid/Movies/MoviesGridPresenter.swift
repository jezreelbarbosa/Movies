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
    func table(isLoading: Bool)
}

public protocol MoviesGridCoordinating: AnyObject {

}

// MARK: - Presenter

public class MoviesGridPresenter<T>: CodePresenter<T> where T: MoviesGridViewable {

    // Properties

    var moviesSet: Set<MovieGridViewModel> = []

    var popularMovies: [MovieGridViewModel] = []
    var popularPage: Int = 1
    var popularIndex: Int = 1

    var searchMovies: [MovieGridViewModel] = []
    var searchPage: Int = 1
    var searchIndex: Int = 1

    var isSearching: Bool = false
    var queryText: String = ""
    var searchConfig: SearchConfigResponse = .onlyOnSearchTyping

    unowned let coordinator: MoviesGridCoordinating
    let popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol
    let getPosterImageUseCase: GetPosterImageUseCaseProtocol
    let searchMoviesPageUseCase: SearchMoviesPageUseCaseProtocol

    // Lifecycle

    public init(coordinator: MoviesGridCoordinating,
                popularMoviesPageUseCase: PopularMoviesPageUseCaseProtocol,
                getPosterImageUseCase: GetPosterImageUseCaseProtocol,
                searchMoviesPageUseCase: SearchMoviesPageUseCaseProtocol) {
        self.coordinator = coordinator
        self.popularMoviesPageUseCase = popularMoviesPageUseCase
        self.getPosterImageUseCase = getPosterImageUseCase
        self.searchMoviesPageUseCase = searchMoviesPageUseCase
    }

    // Functions

    public func fetchPopularMovies() {
        view.table(isLoading: true)
        popularMoviesPageUseCase.execute(page: popularPage, locale: Configs.locale) { [weak self] result in
            guard let self = self else { return }
            result.successHandler { movies in
                self.popularPage += 1
                self.updatePopular(movies: movies.map({ MovieGridViewModel(movie: $0) }))
                self.view.show(movies: self.popularMovies)
            }
            result.failureHandler { error in
                print(error)
            }
            self.view.table(isLoading: false)
        }
    }

    func updatePopular(movies: [MovieGridViewModel]) {
        for movie in movies {
            let (_, member) = moviesSet.insert(movie)
            member.popularIndex = popularIndex
            popularIndex += 1
            getPosterImage(movie: movie)
        }
        popularMovies = moviesSet.filter({ $0.popularIndex.isNotNil }).sorted(by: { $0.popularIndex < $1.popularIndex })
    }

    public func fetchSearchMovies(query: String, isNewQuery: Bool) {
        view.table(isLoading: true)
        if isNewQuery {
            searchPage = 1
            searchIndex = 1
            searchMovies.forEach({ $0.searchIndex = nil })
        }
        let request = SearchMoviesRequest(query: query, locale: Configs.locale, page: searchPage, cancelsLastRequest: isNewQuery)
        searchMoviesPageUseCase.execute(request: request) { [weak self] result in
            guard let self = self else { return }
            result.successHandler { movies in
                self.searchPage += 1
                self.updateSearch(movies: movies.map({ MovieGridViewModel(movie: $0) }))
                self.view.show(movies: self.searchMovies)
            }
            result.failureHandler { error in
                print(error)
            }
            self.view.table(isLoading: false)
        }
    }

    func updateSearch(movies: [MovieGridViewModel]) {
        for movie in movies {
            let (_, member) = moviesSet.insert(movie)
            member.searchIndex = searchIndex
            searchIndex += 1
            getPosterImage(movie: member)
        }
        searchMovies = moviesSet.filter({ $0.searchIndex.isNotNil }).sorted(by: { $0.searchIndex < $1.searchIndex })
    }

    func getPosterImage(movie: MovieGridViewModel) {
        guard let path = movie.movie.posterPath else { return }
        getPosterImageUseCase.execute(path: path) { result in
            result.failureHandler { error in
                debugPrint(error.localizedDescription)
            }
            guard let data = result.success else { return }
            movie.posterImage = UIImage(data: data)
            NotificationCenter.default.post(name: MovieGridViewModel.didDownloadPosterImageNN, object: movie)
        }
    }
}

// MARK: - Presenting

extension MoviesGridPresenter: MoviesGridPresenting {

    public func fetchMoreMovies() {
        if isSearching {
            fetchSearchMovies(query: self.queryText, isNewQuery: false)
        } else {
            fetchPopularMovies()
        }
    }

    public func searchUpdated(queryText: String) {
        self.queryText = queryText
        isSearching = !queryText.isEmpty
        guard isSearching else {
            view.show(movies: self.popularMovies)
            return
        }

        if searchConfig == .onlyOnSearchTyping {
            fetchSearchMovies(query: queryText, isNewQuery: true)
        }
    }

    public func searchButtonClicked(queryText: String) {
        self.queryText = queryText
        self.isSearching = true

        if searchConfig == .onlyOnSearchButton {
            fetchSearchMovies(query: queryText, isNewQuery: true)
        }
    }

    public func didTapOnMovie(_ movie: MovieGridViewModel) {
        print(movie.movie)
    }
}
