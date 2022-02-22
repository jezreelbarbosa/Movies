//
//  RemoteDataErrorDTO.swift
//  AppData
//
//  Created by Jezreel Barbosa on 15/02/22.
//

import Foundation
import Domain

public typealias DataResultCompletion = (Result<Data, RemoteDataErrorDTO>) -> Void

public enum RemoteDataErrorDTO: Error {

    case dataError(Data?)
}

extension RemoteDataErrorDTO {

    public var domainError: DomainError {
        guard case let .dataError(data) = self, let data = data else {
            debugPrint("DomainError unknown error: nil data")
            return .appDataError(.unknownError)
        }
        do {
            let error = try JSONDecoder().decode(RemoteErrors.self, from: data)
            return .remoteError(error)
        } catch let error {
            debugPrint("DomainError decoding error: \(error.localizedDescription)")
            debugPrint("Data: \(String(data: data, encoding: .utf8).default)")
        }
        return .appDataError(.decoderError)
    }
}
