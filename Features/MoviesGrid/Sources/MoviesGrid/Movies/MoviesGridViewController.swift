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

public protocol MoviesGridPresenting: CodePresenting {

}

// MARK: - ViewController

public class MoviesGridViewController: UICodeViewController<MoviesGridPresenting, MoviesGridView> {

    // Properties

    var movies: [MovieGridViewModel] = [
        MovieGridViewModel(image: nil, percent: 0.70, title: "Venom, Let There Be Carnage", date: "Sep 30, 2021"),
        MovieGridViewModel(image: nil, percent: 0.81, title: "Dune", date: "Sep 15, 2021"),
        MovieGridViewModel(image: nil, percent: 0.75, title: "Halloween Kills", date: "Oct 14, 2021"),
        MovieGridViewModel(image: nil, percent: 0.78, title: "Free Guy", date: "Aug 11, 2021"),
        MovieGridViewModel(image: nil, percent: 0.68, title: "Venom", date: "Sep 18, 2018"),
        MovieGridViewModel(image: nil, percent: 0.84, title: "The Seven Deadly Sins: Cursed by Light", date: "Aug 11, 2021"),
        MovieGridViewModel(image: nil, percent: 0.76, title: "The Addams Family 2", date: "Oct 01, 2018")
    ]

    // Lifecycle

    public override func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }

    public override func setupPresenter() {

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
}

// MARK: - Viewable

extension MoviesGridViewController: MoviesGridViewable {

    public func show(movies: [String]) {

    }
}
