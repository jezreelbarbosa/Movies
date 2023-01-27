//
//  CodePresenter.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation

open class CodePresenter<T, U> {

    // Properties

    private unowned var _controller: AnyObject?
    private unowned var _coordinator: AnyObject?

    public var controller: T! { _controller as? T }
    public var coordinator: U! { _coordinator as? U }

    // Lifecycle

    public init() {}

    public func attach(_ controller: T, _ coordinator: U) {
        self._controller = controller as AnyObject
        self._coordinator = coordinator as AnyObject
        didAttachedView()
    }

    open func didAttachedView() {}
}
