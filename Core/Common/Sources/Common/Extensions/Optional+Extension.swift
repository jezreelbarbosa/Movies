//
//  Optional+Extension.swift
//  Common
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation

public extension Optional {

    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool {
        self != nil
    }
}

public func ==<T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public func *<T: FloatingPoint>(lhs: T?, rhs: T?) -> T? {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs*rhs
    default:
        return nil
    }
}

public func /<T: FloatingPoint>(lhs: T?, rhs: T?) -> T? {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs/rhs
    default:
        return nil
    }
}
