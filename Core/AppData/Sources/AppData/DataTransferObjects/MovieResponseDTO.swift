//
//  MovieResponseDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common
import Domain

extension MovieResponse: Decodable {

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
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decodeIfPresent(String.self, forKey: .title).default
        let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate).default
        let releaseDate = DateFormatter("yyyy-MM-dd").date(from: dateString)
        let genreIds = try container.decode([Int].self, forKey: .genreIds)
        let overview = try container.decodeIfPresent(String.self, forKey: .overview).default
        let backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        let posterPath = try container.decode(String?.self, forKey: .posterPath)
        let voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage).default / 10.0
        self.init(id: id, title: title, releaseDate: releaseDate, genreIds: genreIds, overview: overview,
                  backdropPath: backdropPath, posterPath: posterPath, voteAverage: voteAverage)
    }
}
