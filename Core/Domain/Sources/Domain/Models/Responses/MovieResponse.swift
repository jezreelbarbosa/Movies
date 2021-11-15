//
//  MovieResponse.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common

public struct MovieResponse: Decodable {

    // Properties

    public let id: Int
    public let title: String
    public let releaseDate: Date?
    public let genreIds: [Int]
    public let overview: String
    public let backdropPath: String?
    public let posterPath: String?
    public let voteAverage: Double

    // Coding Keys

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }

    // Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title).default
        let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate).default
        self.releaseDate = DateFormatter("yyyy-MM-dd").date(from: dateString)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview).default
        self.backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        self.posterPath = try container.decode(String?.self, forKey: .posterPath)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage).default / 10.0
    }
}
