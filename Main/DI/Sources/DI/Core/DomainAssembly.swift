//
//  DomainAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import Domain

class DomainAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(PopularMoviesPageUseCaseProtocol.self, initializer: PopularMoviesPageUseCase.init)
        container.autoregister(SearchMoviesPageUseCaseProtocol.self, initializer: SearchMoviesPageUseCase.init)
        container.autoregister(GetPosterImageUseCaseProtocol.self, initializer: GetPosterImageUseCase.init)
    }
}
