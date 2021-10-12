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

    func makeViewController() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .blue
        view.tabBarItem.title = "TheMoviesDB"
        return view
    }
}

extension ViewControllersFactory: FavoriteMoviesVCFactory {

    func makeFMViewController() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            view.navigationController?.tabBarItem.title = "Favorite"
        }
        return view
    }
}
