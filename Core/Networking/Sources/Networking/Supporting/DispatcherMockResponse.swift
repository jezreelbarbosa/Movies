//
//  DispatcherMockResponse.swift
//  Networking
//
//  Created by Jezreel Barbosa on 23/02/22.
//

import Foundation

struct DispatcherMockResponse {

    let data: Data?
    let response: URLResponse?
    let error: Error?

    static var empty: DispatcherMockResponse {
        DispatcherMockResponse(data: nil, response: nil, error: nil)
    }
}
