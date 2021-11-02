//
//  MoviesGridTableViewCell.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 23/10/21.
//

import Foundation
import UIKit
import Stevia
import UIComponents

public class MoviesGridTableViewCell: UICodeTableViewCell {

    // Properties

    let leadingMovieView = MovieView()
    let trailingMovieView = MovieView()

    // Lifecycle

    public override func initSubviews() {
        subviews(
            leadingMovieView,
            trailingMovieView
        )
    }

    public override func initLayout() {
        leadingMovieView.top(4).bottom(4).leading(8).Trailing == (contentView.CenterX - 4)
        trailingMovieView.top(4).bottom(4).trailing(8).Leading == (contentView.CenterX + 4)
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = .clear
            s.selectionStyle = .none
        }
    }

    // Overrides

    public override func prepareForReuse() {
        leadingMovieView.prepareForReuse()
        trailingMovieView.prepareForReuse()
    }

    // Functions

    func fill(first: MovieGridViewModel, second: MovieGridViewModel?) {
        leadingMovieView.fill(movie: first)
        trailingMovieView.isHidden = second.isNil
        if let second = second {
            trailingMovieView.fill(movie: second)
        }
    }
}
