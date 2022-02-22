//
//  StorageAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import AppData
import AppStorage

class StorageAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppData.MoviesLocalDataSource.self) { _ in AppStorage.MoviesLocalDataSource(userDefaults: UserDefaultsStorage()) }
    }
}
