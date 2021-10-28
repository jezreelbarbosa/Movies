//
//  LocalizedString.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation

public final class LocalizedString {

    // Static Properties

    public static var appLocale: Locale = .current
    public static var defaultLocale = Locale(identifier: "en_US")

    // Properties

    private var texts: [String: String]

    public var localizedText: String {
        texts[LocalizedString.appLocale.identifier] ?? texts[LocalizedString.defaultLocale.identifier] ?? ""
    }

    // Lifecycle

    public init(texts: [String: String] = [:]) {
        self.texts = texts
    }

    // Functions

    @discardableResult public func addText(_ key: Locale, text: String) -> Self {
        texts[key.identifier] = text
        return self
    }
}

public extension LocalizedString {

    @discardableResult func enUS(_ text: String) -> Self {
        addText(Locale(identifier: "en_US"), text: text)
    }

    @discardableResult func ptBR(_ text: String) -> Self {
        addText(Locale(identifier: "pt_BR"), text: text)
    }
}
