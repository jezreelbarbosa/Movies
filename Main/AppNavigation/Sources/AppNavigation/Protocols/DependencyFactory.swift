//
//  DependencyFactory.swift
//  Common
//
//  Created by Jezreel Barbosa on 29/09/21.
//

import Foundation
import Swinject

public protocol DependencyFactory: AnyObject {

    init(resolver: Resolver)
}
