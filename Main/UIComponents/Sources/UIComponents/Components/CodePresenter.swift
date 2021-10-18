//
//  CodePresenter.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation

open class CodePresenter<T: AnyObject> {

    public private(set) weak var view: T!

    public init() {}

    public func attach(view: T) {
        self.view = view
    }
}
