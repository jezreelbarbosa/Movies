//
//  UIFont+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 19/10/21.
//

import Foundation
import UIKit

public extension UIFont {

    var capAscentHeight: CGFloat {
        ascender - capHeight
    }
}
