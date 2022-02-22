//
//  MoviesRepository.swift
//  Domain
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common

public protocol MoviesRepository {

    func popularMovies(page: Int, locale: String, completion: @escaping DomainResultCompletion<[MovieResponse]>)
    func searchMovies(request: SearchMoviesRequest, completion: @escaping DomainResultCompletion<[MovieResponse]>)
    func posterImage(path: String, completion: @escaping DomainResultCompletion<Data>)
}
