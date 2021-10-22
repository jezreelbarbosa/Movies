//
//  NSCodeLayoutConstraint.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 19/10/21.
//

import Foundation
import UIKit

public class NSCodeLayoutConstraint: NSLayoutConstraint {

    public var originalConstant: CGFloat
    public var style: UIFont.TextStyle
    public var constraint: NSLayoutConstraint

    public init(constraint: NSLayoutConstraint, style: UIFont.TextStyle) {
        self.originalConstant = constraint.constant
        self.style = style
        self.constraint = constraint

        super.init()

        let name = UIContentSizeCategory.didChangeNotification
        NotificationCenter.default.addObserver(self, selector: #selector(changeConstant), name: name, object: nil)
        changeConstant()
    }

    @objc private func changeConstant() {
        constraint.constant = style.metrics.scaledValue(for: originalConstant)
    }
}

public extension NSLayoutConstraint {

    @discardableResult
    func scaledConstant(for style: UIFont.TextStyle = .body) -> NSCodeLayoutConstraint {
        let codeConstraint = NSCodeLayoutConstraint(constraint: self, style: style)
        firstItem?.addConstraint(codeConstraint)
        return codeConstraint
    }
}
