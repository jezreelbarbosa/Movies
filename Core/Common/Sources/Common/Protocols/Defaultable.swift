//
//  Defaultable.swift
//  Common
//
//  Created by Jezreel Barbosa on 15/11/21.
//

import Foundation

public protocol Defaultable {

    static var defaultValue: Self { get }
}

public extension Optional where Wrapped: Defaultable {

    var `default`: Wrapped { return self ?? Wrapped.defaultValue }
}

    // MARK: - Defaultable conformances

extension String: Defaultable {

    public static var defaultValue: String { "" }
}

extension Data: Defaultable {

    public static var defaultValue: Data { Data() }
}

extension Array: Defaultable {

    public static var defaultValue: Array { [] }
}

extension Dictionary: Defaultable {

    public static var defaultValue: [Key: Value] { [:] }
}

extension Int: Defaultable {

    public static var defaultValue: Int { 0 }
}

extension Double: Defaultable {

    public static var defaultValue: Double { 0 }
}
