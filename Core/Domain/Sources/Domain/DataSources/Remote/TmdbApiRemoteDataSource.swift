//
//  TmdbApiRemoteDataSource.swift
//  Domain
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation
import Common

public protocol TmdbApiRemoteDataSource {

    func execute(page: Int, locale: String, completion: @escaping ResultCompletion<[MovieResponse], PopularMoviesPageError>)
}
