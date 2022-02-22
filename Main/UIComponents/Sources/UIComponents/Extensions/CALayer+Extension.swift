//
//  CALayer+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 11/02/22.
//

import UIKit

extension CALayer {

    //  swiftlint:disable all
    public func applyShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        shadowPath = spread == 0 ? nil : UIBezierPath(rect: rect).cgPath
    }
}
