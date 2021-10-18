//
//  FavoriteMoviesCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation
import UIKit
import Domain
import FavoriteMovies

// MARK: - Protocols

public protocol FavoriteMoviesCoordinatorDelegate: CoordinatorDelegate {}

public protocol FavoriteMoviesVCFactory: DependencyFactory {

    func makeFMViewController() -> UIViewController
}

// MARK: - Coordinator

public class FavoriteMoviesCoordinator: NavigationCoordinator {

    // Properties

    weak var delegate: FavoriteMoviesCoordinatorDelegate?

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    let viewControllersFactory: FavoriteMoviesVCFactory

    // Lifecycle

    public init(navigationController: UINavigationController,
                delegate: FavoriteMoviesCoordinatorDelegate?,
                viewControllersFactory: FavoriteMoviesVCFactory) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.viewControllersFactory = viewControllersFactory
        self.childCoordinators = []
    }

    // Functions

    public func start() {
        let viewController = viewControllersFactory.makeFMViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Coordinating

extension FavoriteMoviesCoordinator {

}
