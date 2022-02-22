//
//  RemoteErrorCodes.swift
//  Domain
//
//  Created by Jezreel Barbosa on 15/02/22.
//

import Foundation

// MARK: - Remote Error Code

public enum RemoteErrorCode: String, Error {

    case unknownError = "ERR-001"
}

// MARK: - Remote Errors

public struct RemoteErrors: Decodable, Error {

    // Properties

    public let errors: [RemoteErrorCode: [String]]

    public var firstErrorValue: String? {
        errors.first?.value.first
    }

    // Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dictionary = try container.decode([String: [String]].self, forKey: .errors)
        var newDictionary: [RemoteErrorCode: [String]] = [:]
        for element in dictionary {
            guard let key = RemoteErrorCode(rawValue: element.key) else { continue }
            newDictionary[key] = element.value
        }
        self.errors = newDictionary
    }

    public enum CodingKeys: String, CodingKey {

        case errors
    }
}

// MARK: - Domain Error Extension

extension DomainError {

    public func remoteError(containsError error: RemoteErrorCode) -> Bool {
        guard case let .remoteError(remoteError) = self else { return false }
        return remoteError.errors.keys.contains(error)
    }

    public func remoteError(containsAllErrors errors: [RemoteErrorCode]) -> Bool {
        guard !errors.isEmpty else { return true }
        guard case let .remoteError(error) = self else { return false }
        return error.errors.keys.contains {
            $0 == errors.first ? remoteError(containsAllErrors: Array(errors.dropFirst())) : false
        }
    }

    public func remoteError(containsOneOfTheErrors errors: [RemoteErrorCode]) -> Bool {
        guard case let .remoteError(error) = self else { return false }
        return !Set(error.errors.keys).isDisjoint(with: errors)
    }
}
