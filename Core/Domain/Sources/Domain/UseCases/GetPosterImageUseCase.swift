//
//  GetPosterImageUseCase.swift
//  Domain
//
//  Created by Jezreel Barbosa on 01/11/21.
//

import Foundation
import Common

public protocol GetPosterImageUseCaseProtocol {

    func execute(path: String, completion: @escaping DomainResultCompletion<Data>)
}

public class GetPosterImageUseCase {

    // Properties

    let repository: MoviesRepository

    // Lifecycle

    public init(repository: MoviesRepository) {
        self.repository = repository
    }
}

extension GetPosterImageUseCase: GetPosterImageUseCaseProtocol {

    public func execute(path: String, completion: @escaping DomainResultCompletion<Data>) {
        repository.posterImage(path: path, completion: completion)
    }
}
