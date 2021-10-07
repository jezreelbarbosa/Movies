//
//  ViewControllersFactory.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Common
import Swinject
import Domain
import AppNavigation
import MoviesGrid
import FavoriteMovies

class ViewControllersFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension ViewControllersFactory {

}
