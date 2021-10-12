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
}
