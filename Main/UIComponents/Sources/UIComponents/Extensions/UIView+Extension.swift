//
//  UIView+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 21/11/21.
//

import Foundation
import UIKit

public extension UIView {

    @discardableResult
    func aspectRatio(_ ratio: CGFloat = 1) -> Self {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).setActive()
        return self
    }

    @discardableResult
    func fillSafeArea(_ margin: CGFloat = 0) -> Self {
        guard let spv = superview else { return self }
        topAnchor.constraint(equalTo: spv.safeAreaLayoutGuide.topAnchor, constant: margin).setActive()
        bottomAnchor.constraint(equalTo: spv.safeAreaLayoutGuide.bottomAnchor, constant: margin).setActive()
        leadingAnchor.constraint(equalTo: spv.safeAreaLayoutGuide.leadingAnchor, constant: margin).setActive()
        trailingAnchor.constraint(equalTo: spv.safeAreaLayoutGuide.trailingAnchor, constant: margin).setActive()
        return self
    }
}
