//
//  Array+Extension.swift
//  Common
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation

public extension Array {

    func first<T>(typeOf: T.Type) -> T? {
        first(where: { $0 is T }) as? T
    }

    func element(at index: Index) -> Element? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }

    var halfCountUpRounded: Int {
        Int((Double(count)/2.0).rounded(.up))
    }
}
