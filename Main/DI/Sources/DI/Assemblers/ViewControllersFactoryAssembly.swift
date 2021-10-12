//
//  ViewControllersFactoryAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import AppNavigation

class ViewControllersFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MoviesGridVCFactory.self) { ViewControllersFactory(resolver: $0) }
        container.register(FavoriteMoviesVCFactory.self) { ViewControllersFactory(resolver: $0) }
    }
}
