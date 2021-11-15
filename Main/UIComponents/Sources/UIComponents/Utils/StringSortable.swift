//
//  StringSortable.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 07/11/21.
//

import Foundation

public protocol StringSortable {

    var sortString: String { get }
}

public extension Array where Element: StringSortable {

    func filterContains(_ string: String) -> Self {
        filter { element in
            element.sortString.lowercased().contains(string)
        }
    }

    func prefixSorted(by string: String) -> Self {
        sorted { lhs, rhs in
            let aName = lhs.sortString.lowercased()
            let bName = rhs.sortString.lowercased()
            let isAEqual = aName.prefix(string.count) == string
            let isBEqual = bName.prefix(string.count) == string

            if isAEqual == isBEqual {
                return aName < bName
            } else {
                return isAEqual
            }
        }
    }
}

public extension Set where Element: StringSortable {

    func filterContains(_ string: String) -> Self {
        filter { element in
            element.sortString.lowercased().contains(string)
        }
    }

    func prefixSorted(by string: String) -> [Element] {
        sorted { lhs, rhs in
            let aName = lhs.sortString.lowercased()
            let bName = rhs.sortString.lowercased()
            let isAEqual = aName.prefix(string.count) == string
            let isBEqual = bName.prefix(string.count) == string

            if isAEqual == isBEqual {
                return aName < bName
            } else {
                return isAEqual
            }
        }
    }
}
