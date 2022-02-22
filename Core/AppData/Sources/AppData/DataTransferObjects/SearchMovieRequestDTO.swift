//
//  SearchMovieRequestDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 01/02/22.
//

import Foundation
import Domain

public struct SearchMovieRequestDTO: Encodable {

    public let apiKey: String
    public let query: String
    public let locale: String
    public let page: Int
    public let cancelsLastRequest: Bool

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(apiKey, forKey: .apiKey)
        try container.encode(query, forKey: .query)
        try container.encode(locale, forKey: .locale)
        try container.encode(page, forKey: .page)
    }

    enum CodingKeys: String, CodingKey {

        case apiKey = "api_key"
        case locale = "language"
        case page
        case query
        case cancelsLastRequest
    }
}
