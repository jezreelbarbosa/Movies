//
//  SearchMoviesRequest.swift
//  Domain
//
//  Created by Jezreel Barbosa on 15/11/21.
//

import Foundation
import Common

public struct SearchMoviesRequest {

    public let query: String
    public let locale: String
    public let page: Int
    public let cancelsLastRequest: Bool

    public init(query: String, locale: String, page: Int, cancelsLastRequest: Bool) {
        self.query = query
        self.locale = locale
        self.page = page
        self.cancelsLastRequest = cancelsLastRequest
    }
}
