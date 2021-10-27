//
//  UITableView+Extension.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 23/10/21.
//

import Foundation
import UIKit

public extension UITableView {

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T {
            return cell
        }
        register(cellClass)
        if let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T {
            return cell
        }
        preconditionFailure("Reusable cell is nil: \(cellClass)")
    }

    func register<T: UITableViewHeaderFooterView>(_ headerFooterCellClass: T.Type) {
        register(headerFooterCellClass.self, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterCellClass))
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as? T {
            return cell
        }
        register(cellClass)
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as? T {
            return cell
        }
        preconditionFailure("Reusable cell is nil: \(cellClass)")
    }
}
