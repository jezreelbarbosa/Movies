//
//  AppCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation
import UIKit

public protocol AppCoordinatorFactory: DependencyFactory {

    func makeMoviesGridCoordinator() -> MoviesGridCoordinator
    func makeFavoriteMoviesCoordinator() -> FavoriteMoviesCoordinator
}

public class AppCoordinator: TabBarCoordinator {

    // Properties

    public let tabBarController: UITabBarController
    public var childCoordinators: [Coordinator]

    let window: UIWindow?
    let coordinatorsFactory: AppCoordinatorFactory

    // Lifecycle

    public init(window: UIWindow?, tabBarController: UITabBarController, coordinatorsFactory: AppCoordinatorFactory) {
        self.window = window
        self.childCoordinators = []
        self.tabBarController = tabBarController
        self.coordinatorsFactory = coordinatorsFactory
    }

    // Functions

    public func start() {
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        let moviesGrid = coordinatorsFactory.makeMoviesGridCoordinator()
        let favoriteMovies = coordinatorsFactory.makeFavoriteMoviesCoordinator()

        childCoordinators = [moviesGrid, favoriteMovies]
        tabBarController.viewControllers = [
            moviesGrid.navigationController,
            favoriteMovies.navigationController
        ]

        moviesGrid.start()
        favoriteMovies.start()
    }
}

extension AppCoordinator: MoviesGridCoordinatorDelegate {}

extension AppCoordinator: FavoriteMoviesCoordinatorDelegate {}
