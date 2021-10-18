//
//  MoviesGridPresenter.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import Domain
import UIComponents

// MARK: - Protocols

@objc public protocol MoviesGridViewable {

    func show(movies: [String])
}

public protocol MoviesGridCoordinating: AnyObject {

}

// MARK: - Presenter

public class MoviesGridPresenter: CodePresenter<MoviesGridViewable> {

    // Properties

    unowned let coordinator: MoviesGridCoordinating

    // Lifecycle

    public init(coordinator: MoviesGridCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - Presenting

extension MoviesGridPresenter: MoviesGridPresenting {

}
