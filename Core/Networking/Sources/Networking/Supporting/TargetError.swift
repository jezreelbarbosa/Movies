//
//  File.swift
//  
//
//  Created by Jezreel Barbosa on 15/02/22.
//

import Foundation
import AppData

enum TargetError: Error {

    case urlError
    case requestError(Data?, URLResponse?, Error)
    case unknowError(Data?, URLResponse?, Error?)

    case redirectionError(Data, HTTPURLResponse)
    case clientError(Data, HTTPURLResponse)
    case serverError(Data, HTTPURLResponse)
    case jsonError(Data, HTTPURLResponse)
}

extension TargetError {

    var asDTO: RemoteDataErrorDTO {
        let dataCode: Data?
        switch self {
        case .urlError: dataCode = nil
        case .requestError(let data, _, _): dataCode = data
        case .unknowError(let data, _, _): dataCode = data
        case .redirectionError(let data, _): dataCode = data
        case .clientError(let data, _): dataCode = data
        case .serverError(let data, _): dataCode = data
        case .jsonError(let data, _): dataCode = data
        }
        return .dataError(dataCode)
    }
}
