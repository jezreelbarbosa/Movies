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

    func fetchPopularMovies()
}

// MARK: - ViewController

public class MoviesGridViewController: UICodeViewController<MoviesGridPresenting, MoviesGridView> {

    // Properties

    private var isSearching: Bool = false
    var searchingList: [MovieGridViewModel] = []
    var popularList: [MovieGridViewModel] = []

    var movies: [MovieGridViewModel] { isSearching ? searchingList : popularList }

    // Lifecycle

    public override func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        title = Texts.MoviesGrid.moviesTitle
        addSearchField()
    }

    public override func setupPresenter() {
        presenter.fetchPopularMovies()
    }

    // Functions

    func addSearchField() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Texts.MoviesGrid.searchPlaceholder
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
            cell.fill(first: first, second: movies.element(at: index + 1))
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.halfCountUpRounded - 1 {
            mainView.table(isLoading: true)
            if isSearching {

            } else {
                presenter.fetchPopularMovies()
            }
        }
    }
}

// MARK: - UISearchResultsUpdating

extension MoviesGridViewController: UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }

    func filterContentForSearchText(_ searchText: String?) {
        if let searchText = searchText?.lowercased(), !searchText.isEmpty {
            isSearching = true
            searchingList = popularList.filterContains(searchText).prefixSorted(by: searchText)
        } else {
            isSearching = false
        }
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}

// MARK: - Viewable

extension MoviesGridViewController: MoviesGridViewable {

    public func show(movies: [MovieGridViewModel]) {
        self.popularList = movies
        mainView.table(isLoading: false)
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}
