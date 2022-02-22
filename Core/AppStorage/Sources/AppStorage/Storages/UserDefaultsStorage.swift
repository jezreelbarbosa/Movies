//
//  UserDefaultsStorage.swift
//  AppStorage
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation

public class UserDefaultsStorage {

    // Properties

    public let userDefaults: UserDefaults

    // Lifecycle

    public required init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // Keys

    public enum ValueKeyable: String, CaseIterable {

        /// String
        case apiKey

        public var key: String {
            return rawValue
        }
    }

    // Functions

    public func set(_ value: Any?, keyable: ValueKeyable) {
        userDefaults.set(value, forKey: keyable.key)
    }

    public func get<T>(_ type: T.Type, keyable: ValueKeyable) -> T? {
        return userDefaults.object(forKey: keyable.key) as? T
    }

    public func removeItem(keyable: ValueKeyable) {
        userDefaults.removeObject(forKey: keyable.key)
    }

    public func removeAll() {
        ValueKeyable.allCases.forEach { key in
            removeItem(keyable: key)
        }
    }
}
