//
//  RemoteErrorLocalized.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 16/02/22.
//

import Foundation
import Domain

extension RemoteErrorCode: LocalizedError {

    public var errorDescription: String? {
        switch self {
//        case .remoteErrorE001:
//            return "Código de erro 001"
        case .unknownError:
            return "Erro desconhecido"
        }
    }
}
