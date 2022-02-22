//
//  MovieURLRequestDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common

public struct MovieURLRequestDTO: Encodable {

    public let apiKey: String
    public let locale: String
    public let page: String

    enum CodingKeys: String, CodingKey {

        case apiKey = "api_key"
        case locale = "language"
        case page
    }
}
