//
//  TmdbApiTargets.swift
//  Networking
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common
import AppData

enum TmdbApiTargets {

    case popular(MovieURLRequestDTO)
    case search(SearchMovieRequestDTO)
    case posterImage(String)
}

extension TmdbApiTargets: TargetType {

    var baseURL: String {
        switch self {
        case .popular, .search:
            return "https://api.themoviedb.org"
        case .posterImage:
            return "https://image.tmdb.org"
//            return "https://api.themoviedb.org"
        }
    }

    var version: String {
        return "3"
    }

    var path: String {
        switch self {
        case .popular:
            return "/\(version)/movie/popular"
        case .search:
            return "/\(version)/search/movie"
        case .posterImage(let path):
            return "/t/p/w342\(path)"
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .popular(let request): return request.parameters
        case .search(let request): return request.parameters
        case .posterImage: return nil
        }
    }

    var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .popular: return .reloadIgnoringLocalAndRemoteCacheData
        case .search: return .reloadIgnoringLocalAndRemoteCacheData
        case .posterImage: return .reloadRevalidatingCacheData
        }
    }

    var method: String {
        "GET"
    }

    var body: Data? {
        nil
    }

    var headers: [String: String]? {
        nil
    }
}
