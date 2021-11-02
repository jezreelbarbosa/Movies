//
//  GetPosterImageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 01/11/21.
//

import Foundation
import Common

public enum GetPosterImageError: Error {

    case requestError(Error?)
    case jsonError(Error)
}

public protocol GetPosterImageUseCaseProtocol {

    func execute(path: String, completion: @escaping ResultCompletion<Data, GetPosterImageError>)
}

public class GetPosterImageUseCase {

    // Properties

    let remote: TmdbApiRemoteDataSource

    // Lifecycle

    public init(remote: TmdbApiRemoteDataSource) {
        self.remote = remote
    }
}

extension GetPosterImageUseCase: GetPosterImageUseCaseProtocol {

    public func execute(path: String, completion: @escaping ResultCompletion<Data, GetPosterImageError>) {
        remote.getPosterImage(path: path, completion: completion)
    }
}
