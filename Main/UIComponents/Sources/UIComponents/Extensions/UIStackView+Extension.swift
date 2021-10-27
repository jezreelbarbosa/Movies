//
//  UIStackView+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 23/10/21.
//

import Foundation
import UIKit

public extension UIStackView {

    @discardableResult
    func asv(_ arrengedSubviews: UIView...) -> Self {
        asv(arrengedSubviews)
        return self
    }

    @discardableResult
    func asv(_ arrengedSubviews: [UIView]) -> Self {
        arrengedSubviews.forEach { subViews in
            addArrangedSubview(subViews)
        }
        return self
    }

    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        arrangedSubviews.reduce([UIView](), { $0 + [removeArrengedSubviewProperly($1)] })
    }

    @discardableResult
    func removeArrengedSubviewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}
