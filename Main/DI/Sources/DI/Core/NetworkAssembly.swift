//
//  NetworkAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/10/21.
//

import Foundation
import Swinject
import Domain
import Networking

class NetworkingAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(Domain.TmdbApiRemoteDataSource.self, initializer: Networking.TmdbApiRemoteDataSource.init)
    }
}
