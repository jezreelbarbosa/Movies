//
//  CoordinatorsFactoryAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import AppNavigation

class CoordinatorsFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppCoordinatorFactory.self) { CoordinatorsFactory(resolver: $0) }
    }
}
