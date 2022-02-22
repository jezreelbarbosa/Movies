//
//  TmdbApiRemoteDataSource.swift
//  AppData
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common
import Domain

public protocol TmdbApiRemoteDataSource {

    func getPopularMovies(request: MovieURLRequestDTO, completion: @escaping DataResultCompletion)
    func getSearchMovies(request: SearchMovieRequestDTO, completion: @escaping DataResultCompletion)
    func getPosterImage(path: String, completion: @escaping DataResultCompletion)
}
