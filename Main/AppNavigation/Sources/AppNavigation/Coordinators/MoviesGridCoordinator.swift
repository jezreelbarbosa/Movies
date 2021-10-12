//
//  MoviesGridCoordinator.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation
import UIKit
import Domain
import FavoriteMovies

public protocol MoviesGridCoordinatorDelegate: CoordinatorDelegate {}

public protocol MoviesGridVCFactory: DependencyFactory {

    func makeViewController() -> UIViewController
}

public class MoviesGridCoordinator: NavigationCoordinator {

    // Properties

    weak var delegate: MoviesGridCoordinatorDelegate?

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]

    let viewControllersFactory: MoviesGridVCFactory

    // Lifecycle

    public init(navigationController: UINavigationController,
                delegate: MoviesGridCoordinatorDelegate?,
                viewControllersFactory: MoviesGridVCFactory) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.viewControllersFactory = viewControllersFactory
        self.childCoordinators = []
    }

    // Functions

    public func start() {
        let viewController = viewControllersFactory.makeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
