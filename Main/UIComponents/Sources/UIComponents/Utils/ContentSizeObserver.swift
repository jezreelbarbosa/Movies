//
//  ContentSizeObserver.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 22/10/21.
//

import Foundation
import UIKit

public protocol ContentSizeObserver: NotificationTokenObserver {

    func addContentSizeObserver(andFire fire: Bool, contentSizeCategoryDidChange completion: @escaping (UIContentSizeCategory) -> Void)
}

public extension ContentSizeObserver where Self: UITraitEnvironment {

    func addContentSizeObserver(andFire fire: Bool = true, contentSizeCategoryDidChange completion: @escaping (UIContentSizeCategory) -> Void) {
        addObserver(name: UIContentSizeCategory.didChangeNotification) { [weak self] _ in
            guard let self = self else { return }

            completion(self.traitCollection.preferredContentSizeCategory)
        }
        if fire {
            completion(traitCollection.preferredContentSizeCategory)
        }
    }
}
