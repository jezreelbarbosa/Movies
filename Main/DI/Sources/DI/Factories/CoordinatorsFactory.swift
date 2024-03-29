//
//  CoordinatorsFactory.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Common
import Swinject
import AppNavigation

class CoordinatorsFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension CoordinatorsFactory: AppCoordinatorFactory {

    func makeMoviesGridCoordinator() -> MoviesGridCoordinator {
        resolver.resolveSafe(MoviesGridCoordinator.self)
    }

    func makeFavoriteMoviesCoordinator() -> FavoriteMoviesCoordinator {
        resolver.resolveSafe(FavoriteMoviesCoordinator.self)
    }
}
