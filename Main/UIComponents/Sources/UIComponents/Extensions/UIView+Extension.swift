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
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: ratio).setActive()
        return self
    }
}
