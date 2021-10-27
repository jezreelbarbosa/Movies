//
//  UIColor+dynamicColor.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 22/10/21.
//

import Foundation
import UIKit

public extension UIColor {

    static func dynamic(any anyColor: UIColor, dark darkColor: UIColor? = nil) -> UIColor {
        guard #available(iOS 13, *) else { return anyColor }

        return UIColor { (uiTraitCollection: UITraitCollection) -> UIColor in
            guard uiTraitCollection.userInterfaceStyle == .dark, let darkColor = darkColor else { return anyColor }
            return darkColor
        }
    }
}
