//
//  DependencyInjector.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Common
import UIKit
import Swinject
import SwinjectAutoregistration
import Domain
import AppNavigation

public class DependencyInjector {

    // Properties

    private weak var window: UIWindow?

    // Initialization

    public init(window: UIWindow?) {
        self.window = window
    }

    // Function

    public func build(completion: (_ assembler: Assembler, _ appCoordinator: AppCoordinator) -> Void) {
        let assembler = Assembler([
            // Core Assemblers
            DomainAssembly(),
            AppDataAssembly(),
            StorageAssembly(),
            NetworkingAssembly(),

            // Factory Assemblers
            CoordinatorsFactoryAssembly(),
            ViewControllersFactoryAssembly(),

            // Main Assemblers
            CoodinatorAssembly(window: window),
            FeatureAssembly()
        ])
        let appCoordinator = assembler.resolver.resolveSafe(AppCoordinator.self)
        completion(assembler, appCoordinator)
    }
}
