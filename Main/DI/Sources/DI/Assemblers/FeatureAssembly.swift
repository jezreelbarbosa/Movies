//
//  FeatureAssembly.swift
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

class FeatureAssembly: Assembly {

    func assemble(container: Container) {
        assembleMoviesGrid(container: container)
        assembleFavoriteMovies(container: container)
    }

    func assembleMoviesGrid(container: Container) {

    }

    func assembleFavoriteMovies(container: Container) {

    }
}
