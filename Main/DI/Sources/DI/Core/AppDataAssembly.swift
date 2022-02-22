//
//  AppDataAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import Domain
import AppData

class AppDataAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(Domain.MoviesRepository.self, initializer: AppData.MoviesRepository.init)
    }
}
