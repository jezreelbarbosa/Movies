//
//  FontRegistrable.swift
//  UICompenents
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit

public protocol FontRegistrable: RawRepresentable {

    static var familyName: String { get }

    var name: String { get }
    var useOnlyRawValueName: Bool { get }
    var bundle: Bundle { get }
    var fileType: String { get }
    var asSystemFontWeight: UIFont.Weight { get }
    var pointsByScreenSize: CGFloat { get }
    var boldTextAccessibility: Self { get }

    func maximumPointsToIncreaseSize(for style: UIFont.TextStyle) -> CGFloat
    func fontSize(for style: UIFont.TextStyle) -> CGFloat
    func fixedFont(size: CGFloat, tryToRegister: Bool) -> UIFont
    func font(_ style: UIFont.TextStyle, size: CGFloat?, maximumSize: CGFloat?, boldAccessibility: Self?) -> UIFont
}

public extension FontRegistrable where RawValue == String {

    static var familyName: String {
        String(describing: self)
    }

    var name: String {
        useOnlyRawValueName ? rawValue : Self.familyName + "-" + rawValue.capitalizingFirstLetter()
    }

    var useOnlyRawValueName: Bool {
        false
    }

    var bundle: Bundle {
        .main
    }

    var fileType: String {
        "ttf"
    }

    var asSystemFontWeight: UIFont.Weight {
        .regular
    }

    var pointsByScreenSize: CGFloat {
        switch UIScreen.main.bounds.width {
        case ...320: return 0
        case ...390: return 1
        case ...428: return 3
        default: return 4
        }
    }

    var boldTextAccessibility: Self {
        return self
    }

    func maximumPointsToIncreaseSize(for style: UIFont.TextStyle) -> CGFloat {
        return .greatestFiniteMagnitude
    }

    func fontSize(for style: UIFont.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return 34
        case .title1: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 18
        case .body: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption1: return 12
        case .caption2: return 11
        default: return 17
        }
    }

    func fixedFont(size: CGFloat, tryToRegister: Bool = true) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        if tryToRegister {
            Self.register(fileNameString: name, type: fileType, bundle: bundle)
            return fixedFont(size: size, tryToRegister: false)
        }
        debugPrint("Warning: \(name) font not registered.")
        return .systemFont(ofSize: size, weight: asSystemFontWeight)
    }

    func font(_ style: UIFont.TextStyle = .body, size: CGFloat? = nil, maximumSize: CGFloat? = nil, boldAccessibility: Self? = nil) -> UIFont {
        let fontSize = (size ?? fontSize(for: style)) + pointsByScreenSize
        let maximumPointSize = maximumSize ?? (fontSize + maximumPointsToIncreaseSize(for: style))
        let boldAccessibility = boldAccessibility ?? boldTextAccessibility
        let font = UIAccessibility.isBoldTextEnabled ? boldAccessibility.fixedFont(size: fontSize) : fixedFont(size: fontSize)
        return style.metrics.scaledFont(for: font, maximumPointSize: maximumPointSize)
    }
}

private extension FontRegistrable where RawValue == String {

    static func register(fileNameString: String, type: String, bundle: Bundle) {
        guard let resourceBundleURL = bundle.url(forResource: fileNameString, withExtension: type),
              let dataProvider = CGDataProvider(url: resourceBundleURL as CFURL),
              let fontRef = CGFont(dataProvider),
              CTFontManagerRegisterGraphicsFont(fontRef, nil)
        else {
            debugPrint("Register font error: \(fileNameString).\(type) at \(bundle)")
            return
        }
    }
}
