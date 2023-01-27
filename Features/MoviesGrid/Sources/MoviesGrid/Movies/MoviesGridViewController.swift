//
//  MoviesGridViewController.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import UIKit
import UIComponents

// MARK: - Protocols

public protocol MoviesGridPresenting {

    func fetchMoreMovies()
    func searchUpdated(queryText: String)
    func searchButtonClicked(queryText: String)
    func didTapOnMovie(_ movie: MovieGridViewModel)
}

// MARK: - ViewController

public class MoviesGridViewController: UICodeViewController<MoviesGridPresenting, MoviesGridView> {

    // Properties

    var movies: [MovieGridViewModel] = []

    // Lifecycle

    public override func setupView() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        title = Texts.MoviesGrid.moviesTitle
        navigationItem.backButtonTitle = "    "
        addSearchField()
    }

    public override func setupPresenter() {
        presenter.fetchMoreMovies()
    }

    // Functions

    func addSearchField() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Texts.MoviesGrid.searchPlaceholder
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
}

// MARK: - TableView

extension MoviesGridViewController: UITableViewDataSource, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.halfCountUpRounded
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MoviesGridTableViewCell.self)
        let index = indexPath.row * 2

        if let first = movies.element(at: index) {
            let second = movies.element(at: index + 1)

            cell.fill(first: first, second: second)

            cell.setActions { [unowned self] movie in
                presenter.didTapOnMovie(movie)
            } secondAction: { [unowned self] movie in
                presenter.didTapOnMovie(movie)
            }
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.halfCountUpRounded - 1 {
            presenter.fetchMoreMovies()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension MoviesGridViewController: UISearchResultsUpdating, UISearchBarDelegate {

    public func updateSearchResults(for searchController: UISearchController) {
        presenter.searchUpdated(queryText: searchController.searchBar.text.default)
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonClicked(queryText: searchBar.text.default)
    }
}

// MARK: - Viewable

extension MoviesGridViewController: MoviesGridViewable {

    public func show(movies: [MovieGridViewModel]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.rootView.tableView.reloadData()
        }
    }

    public func table(isLoading: Bool) {
        rootView.table(isLoading: isLoading)
    }
}
