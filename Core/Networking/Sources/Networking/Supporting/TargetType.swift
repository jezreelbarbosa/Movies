//
//  TargetType.swift
//  Networking
//
//  Created by Jezreel Barbosa on 15/02/22.
//

import Foundation

typealias TargetCompletion = (Result<(data: Data, response: HTTPURLResponse), TargetError>) -> Void

protocol TargetType {

    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var method: String { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
}
