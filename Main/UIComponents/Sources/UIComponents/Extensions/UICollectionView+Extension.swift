//
//  UICollectionView+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 17/10/21.
//

import Foundation
import UIKit

public extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T {
            return cell
        }
        preconditionFailure("Reusable cell is nil: \(cellClass)")
    }
}
