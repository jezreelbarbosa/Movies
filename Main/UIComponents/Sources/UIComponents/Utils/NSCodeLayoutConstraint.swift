//
//  NSCodeLayoutConstraint.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 19/10/21.
//

import Foundation
import UIKit

public class NSCodeLayoutConstraint: NSLayoutConstraint {

    // Properties

    public weak var constraint: NSLayoutConstraint?
    private var token: NSObjectProtocol!

    // Lifecycle

    public init(constraint: NSLayoutConstraint, style: UIFont.TextStyle, maxValue: CGFloat?) {
        self.constraint = constraint
        super.init()

        let name = UIContentSizeCategory.didChangeNotification
        let originalConstant = constraint.constant
        self.token = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [unowned self] _ in
            changeConstant(style: style, originalConstant: originalConstant, maxValue: maxValue)
        }
        changeConstant(style: style, originalConstant: originalConstant, maxValue: maxValue)
    }

    public init(constraint: NSLayoutConstraint, style: UIFont.TextStyle, minValue: CGFloat?) {
        self.constraint = constraint
        super.init()

        let name = UIContentSizeCategory.didChangeNotification
        let originalConstant = constraint.constant
        self.token = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [unowned self] _ in
            changeConstant(style: style, originalConstant: originalConstant, minValue: minValue)
        }
        changeConstant(style: style, originalConstant: originalConstant, minValue: minValue)
    }

    deinit {
        guard let token = token else { return }
        NotificationCenter.default.removeObserver(token)
    }

    // Functions

    private func changeConstant(style: UIFont.TextStyle, originalConstant: CGFloat, minValue: CGFloat?) {
        let scaled = style.metrics.scaledValue(for: originalConstant)
        if let minValue = minValue {
            constraint?.constant = max(scaled, minValue)
        } else {
            constraint?.constant = scaled
        }
    }

    private func changeConstant(style: UIFont.TextStyle, originalConstant: CGFloat, maxValue: CGFloat?) {
        let scaled = style.metrics.scaledValue(for: originalConstant)
        if let maxValue = maxValue {
            constraint?.constant = min(scaled, maxValue)
        } else {
            constraint?.constant = scaled
        }
    }
}

// MARK: - NSLayoutConstraint Extension

public extension NSLayoutConstraint {

    @discardableResult
    func scaledConstant(for style: UIFont.TextStyle = .body) -> NSCodeLayoutConstraint {
        let codeConstraint = NSCodeLayoutConstraint(constraint: self, style: style, maxValue: nil)
        firstItem?.addConstraint(codeConstraint)
        return codeConstraint
    }

    /// Used for positive constants
    @discardableResult
    func scaledConstant(for style: UIFont.TextStyle = .body, maxValue: CGFloat) -> NSCodeLayoutConstraint {
        let codeConstraint = NSCodeLayoutConstraint(constraint: self, style: style, maxValue: maxValue)
        firstItem?.addConstraint(codeConstraint)
        return codeConstraint
    }

    /// Used for negative constants
    @discardableResult
    func scaledConstant(for style: UIFont.TextStyle = .body, minValue: CGFloat) -> NSCodeLayoutConstraint {
        let codeConstraint = NSCodeLayoutConstraint(constraint: self, style: style, minValue: minValue)
        firstItem?.addConstraint(codeConstraint)
        return codeConstraint
    }

    @discardableResult
    func setActive(_ active: Bool = true) -> Self {
        isActive = active
        return self
    }
}
