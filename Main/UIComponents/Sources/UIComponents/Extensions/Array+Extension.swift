//
//  Array+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 19/10/21.
//

import Foundation

public extension Array {

    func element(at index: Index) -> Element? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
}
