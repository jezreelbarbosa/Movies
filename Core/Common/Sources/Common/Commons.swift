//
//  Commons.swift
//  Common
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation

public typealias VoidCompletion = () -> Void

public typealias ResultCompletion<T> = (Result<T, Error>) -> Void

public enum TestMockError: Error {

    case error
}
