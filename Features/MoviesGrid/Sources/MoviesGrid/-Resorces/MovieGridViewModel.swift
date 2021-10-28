//
//  MovieGridViewModel.swift
//  MovieGrid
//
//  Created by Jezreel Barbosa on 23/10/21.
//

import Foundation
import UIKit
import Domain

public class MovieGridViewModel {

    // Model

    let movie: MovieResponse

    // Lifecycle

    init(movie: MovieResponse) {
        self.movie = movie
    }

    // Properties

    var popularIndex: Int?

    var percent: CGFloat {
        movie.voteAverage
    }

    var title: String {
        movie.title
    }

    var date: String {
        guard let releaseDate = movie.releaseDate else { return "--" }
        return DateFormatter(Configs.dateFormat).string(from: releaseDate)
    }

    // Functions
}

extension MovieGridViewModel: Equatable, Hashable {

    public static func == (lhs: MovieGridViewModel, rhs: MovieGridViewModel) -> Bool {
        lhs.movie.id == rhs.movie.id
    }

    public func hash(into hasher: inout Hasher) {}
}
