//
//  TmdbApiRemoteDataSource.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common

public protocol TmdbApiRemoteDataSource {

    func getPopularMovies(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>)
    func getSearchMovies(request: SearchMoviesRequest, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>)
    func getPosterImage(path: String, completion: @escaping ResultCompletion<Data, GetPosterImageError>)
}
