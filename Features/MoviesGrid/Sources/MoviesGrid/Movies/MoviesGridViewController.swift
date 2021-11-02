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

    var movies: [MovieGridViewModel] = []

    // Lifecycle

    public override func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        title = Texts.MoviesGrid.moviesTitle
    }

    public override func setupPresenter() {
        presenter.fetchPopularMovies()
    }

    // Functions

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
            presenter.fetchPopularMovies()
        }
    }
}

// MARK: - Viewable

extension MoviesGridViewController: MoviesGridViewable {

    public func show(movies: [MovieGridViewModel]) {
        self.movies = movies
        mainView.table(isLoading: false)
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}
