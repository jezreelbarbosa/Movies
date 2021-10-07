//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import UIKit
import Common
import Swinject
import AppNavigation

class CoodinatorAssembly: Assembly {

    // Properties

    private let window: UIWindow?

    // Lifecycle

    init(window: UIWindow?) {
        self.window = window
    }

    func assemble(container: Container) {
        assembleAppCoordinator(container: container)
    }

    // Assemblers

    private func assembleAppCoordinator(container: Container) {
        let navigationController = UINavigationController()
        let coordinatorsFactory = container.resolveSafe(AppCoordinatorsFactoryProtocol.self)
        container.register(AppCoordinator.self) { _ in
           AppCoordinator(window: self.window, navigationController: navigationController, coordinatorsFactory: coordinatorsFactory)
        }
    }
}
