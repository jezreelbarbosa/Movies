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

    private let window: UIWindow?

    // Initialization

    public init(window: UIWindow?) {
        self.window = window
    }

    // Function

    public func build(completion: (_ assembler: Assembler, _ appCoordinator: AppCoordinator) -> Void) {
        let assembler = Assembler([
            // Assembler Principal
            CoordinatorsFactoryAssembly(),
            ViewControllersFactoryAssembly(),
            CoodinatorAssembly(window: self.window),

            // Assembler dos frameworks
            DomainAssembly(),
            AppDataAssembly(),
            NetworkingAssembly(),
            StorageAssembly(),

            // Assembler das features
            FeatureAssembly()
        ])
        let appCoordinator = assembler.resolver.resolveSafe(AppCoordinator.self)
        completion(assembler, appCoordinator)
    }
}
