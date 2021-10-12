//
//  CorrdinatorProtocol.swift
//  AppNavigation
//
//  Created by Jezreel Barbosa on 12/10/21.
//

import Foundation
import UIKit
import Swinject

public protocol CoordinatorDelegate: AnyObject {

    func coordinatorDidExit(_ coordinator: Coordinator)
}

public protocol Coordinator: CoordinatorDelegate {

    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {

    public func coordinatorDidExit(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

public protocol TabBarCoordinator: Coordinator {

    var tabBarController: UITabBarController { get }
}

public protocol NavigationCoordinator: Coordinator {

    var navigationController: UINavigationController { get }
}
