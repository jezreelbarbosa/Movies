//
//  MovieResponse.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation

public struct MovieResponse {

    // Properties

    public let id: Int
    public let title: String
    public let releaseDate: Date?
    public let genreIds: [Int]
    public let overview: String
    public let backdropPath: String?
    public let posterPath: String?
    public let voteAverage: Double

    // Lifecycle

    public init(id: Int, title: String, releaseDate: Date?, genreIds: [Int], overview: String,
                backdropPath: String?, posterPath: String?, voteAverage: Double) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.voteAverage = voteAverage
    }
}
