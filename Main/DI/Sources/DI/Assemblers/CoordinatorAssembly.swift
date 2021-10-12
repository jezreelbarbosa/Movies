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

    private weak var window: UIWindow?

    // Lifecycle

    init(window: UIWindow?) {
        self.window = window
    }

    func assemble(container: Container) {
        assembleAppCoordinator(container: container)
        assembleMoviesGridCoordinator(container: container)
        assembleFavoriteMoviesCoordinator(container: container)
    }

    // Assemblers

    func assembleAppCoordinator(container: Container) {
        let tabBar = UITabBarController()
        let factory = container.resolveSafe(AppCoordinatorFactory.self)
        let appCoordinator = AppCoordinator(window: window, tabBarController: tabBar, coordinatorsFactory: factory)
        container.register(AppCoordinator.self) { _ in appCoordinator }
    }

    func assembleMoviesGridCoordinator(container: Container) {
        container.register(MoviesGridCoordinator.self) { resolver in
            let appCoordinator = resolver.resolveSafe(AppCoordinator.self)
            return appCoordinator.childCoordinators.first(typeOf: MoviesGridCoordinator.self) ??
            MoviesGridCoordinator(navigationController: UINavigationController(), delegate: appCoordinator,
                                  viewControllersFactory: resolver.resolveSafe(MoviesGridVCFactory.self))
        }
    }

    func assembleFavoriteMoviesCoordinator(container: Container) {
        container.register(FavoriteMoviesCoordinator.self) { resolver in
            let appCoordinator = resolver.resolveSafe(AppCoordinator.self)
            return appCoordinator.childCoordinators.first(typeOf: FavoriteMoviesCoordinator.self) ??
            FavoriteMoviesCoordinator(navigationController: UINavigationController(), delegate: appCoordinator,
                                      viewControllersFactory: resolver.resolveSafe(FavoriteMoviesVCFactory.self))
        }
    }
}
