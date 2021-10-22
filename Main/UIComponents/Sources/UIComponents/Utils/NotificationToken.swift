//
//  NotificationToken.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 19/10/21.
//

import Foundation
import UIKit

public final class NotificationToken {

    private let notificationCenter: NotificationCenter
    private let token: NSObjectProtocol

    public init(notificationCenter: NotificationCenter = .default, token: NSObjectProtocol) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        notificationCenter.removeObserver(token)
    }
}

public extension NotificationCenter {

    func addObserver(name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?,
                     using block: @escaping (Notification) -> Void) -> NotificationToken {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken(notificationCenter: self, token: token)
    }
}

public protocol NotificationTokenObserver: AnyObject {

    var notificationTokens: [NotificationToken] { get set }
    func addObserver(name: NSNotification.Name?, object: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void)
}

public extension NotificationTokenObserver {

    func addObserver(name: NSNotification.Name?, object: Any? = nil, queue: OperationQueue? = .main, using block: @escaping (Notification) -> Void) {
        let token = NotificationCenter.default.addObserver(name: name, object: object, queue: queue, using: block)
        notificationTokens.append(token)
    }
}
