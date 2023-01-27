import Foundation
import Swinject

public protocol DependencyFactory: AnyObject {
    init(resolver: Resolver)
}
