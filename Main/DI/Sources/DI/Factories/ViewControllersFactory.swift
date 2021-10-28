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
import UIKit

class ViewControllersFactory: DependencyFactory {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension ViewControllersFactory: MoviesGridVCFactory {

    func makeMoviesGridViewController() -> MoviesGridViewController {
        let presenter = resolver.resolveSafe(MoviesGridPresenter<MoviesGridViewController>.self)
        let controller = MoviesGridViewController(presenter: presenter)
        presenter.attach(view: controller)
        return controller
    }
}

extension ViewControllersFactory: FavoriteMoviesVCFactory {

    func makeFMViewController() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .red
        return view
    }
}
