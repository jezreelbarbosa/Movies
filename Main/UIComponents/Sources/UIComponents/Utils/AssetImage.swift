//
//  AssetImage.swift
//  UIComponent
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit.UIImage

public protocol AssetImage: RawRepresentable {

    var image: UIImage? { get }
}

extension AssetImage where RawValue == String {

    public var image: UIImage? {
        UIImage(named: rawValue)
    }

    public var safeImage: UIImage {
        image ?? UIImage()
    }
}
