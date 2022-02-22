//
//  DomainError.swift
//  Domain
//
//  Created by Jezreel Barbosa on 16/02/22.
//

import Foundation

public typealias DomainResultCompletion<T> = (Result<T, DomainError>) -> Void

public enum DomainError: Error {

    case appDataError(AppDataError)
    case remoteError(RemoteErrors)
}

extension DomainError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .appDataError(let error):
            return error.localizedDescription
        case .remoteError(let error):
            return error.localizedDescription
        }
    }
}
