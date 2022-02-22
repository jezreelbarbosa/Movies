//
//  File.swift
//  
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common
import AppData

public class MoviesLocalDataSource {

    // Properties

    let userDefaults: UserDefaultsStorage

    // Lifecycle

    public init(userDefaults: UserDefaultsStorage) {
        self.userDefaults = userDefaults

        // Making api key static
        userDefaults.set("72ee2814ce7d37165e7a836cc8cf9186", keyable: .apiKey)
    }
}

// MARK: - AppDataDataSource

extension MoviesLocalDataSource: AppData.MoviesLocalDataSource {

    public func getApiKey() -> String? {
        userDefaults.get(String.self, keyable: .apiKey)
    }
}
