//
//  CirclePercentView.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit
import Stevia
import Common

public class CirclePercentView: UICodeView, ContentSizeObserver {

    // Properties

    public var value: CGFloat? {
        didSet { setNeedsDisplay() }
    }
    public var startAngle: CGFloat = -.pi/2.0
    public var arcSpam: CGFloat = 0
    public var arcWidth: CGFloat = 10

    public var arcColorValues: [CGFloat] = []
    public var arcForegroundColors: [UIColor] = []
    public var arcBackgroundColors: [UIColor] = []

    public var cirleColor: UIColor = .clear
    public var arcBackgroundNilColor: UIColor = .clear

    public var fontSize: CGFloat = 14 {
        didSet { updateFonts() }
    }
    public var fontMaxSize: CGFloat? {
        didSet { updateFonts() }
    }

    public var notificationTokens: [NotificationToken] = []

    private weak var timer: Timer?

    // Views

    private let stackView = UIStackView()
    private let valueLabel = UILabel()
    private let percentView = UIView()
    private let percentLabel = UILabel()

    // Lifecycle

    public override func initSubviews() {
        subviews(stackView)
        percentView.subviews(percentLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(percentView)
    }

    public override func initLayout() {
        stackView.centerInContainer()
        stackView.top(>=0).bottom(>=0).leading(>=0).trailing(>=0)
        percentLabel.fillHorizontally().top(0).bottom(>=0)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        percentLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    public override func initStyle() {
        stackView.style { s in
            s.axis = .horizontal
        }
        valueLabel.style { s in
            s.font = Rubik.regular.font(.subheadline, size: fontSize)
            s.textColor = Palette.White.white
            s.textAlignment = .center
            s.lineBreakMode = .byClipping
            s.minimumScaleFactor = 0.1
            s.adjustsFontSizeToFitWidth = true
            s.adjustsFontForContentSizeCategory = true
        }
        percentLabel.style { s in
            s.text = "%"
            s.font = Rubik.regular.font(.subheadline, size: fontSize/3)
            s.textColor = Palette.White.white
            s.textAlignment = .center
            s.lineBreakMode = .byClipping
            s.minimumScaleFactor = 0.1
            s.adjustsFontSizeToFitWidth = true
            s.adjustsFontForContentSizeCategory = true
        }
    }

    // Overrides

    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let fullCircle: CGFloat = 2.0 * .pi
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let side: CGFloat = min(rect.width, rect.height)
        let radius: CGFloat = (side - arcWidth) / 2.0 - arcSpam

        context.clear(rect)
        context.setLineCap(.round)
        context.setFillColor(cirleColor.cgColor)
        context.fillEllipse(in: CGRect(x: (rect.width-side)/2, y: (rect.height-side)/2, width: side, height: side))

        guard let value = value else {
            valueLabel.text = "NR"
            percentView.isHidden = true
            context.setStrokeColor(arcBackgroundNilColor.cgColor)
            context.setLineWidth(arcWidth)
            context.addArc(center: center, radius: radius, startAngle: 0, endAngle: fullCircle, clockwise: false)
            context.strokePath()
            return
        }

        let endAngle: CGFloat = value * fullCircle + startAngle

        if let index = arcColorValues.firstIndex(where: { $0 > value }), let color = arcBackgroundColors.element(at: index) {
            context.setStrokeColor(color.cgColor)
        } else {
            context.setStrokeColor(UIColor.clear.cgColor)
        }
        context.setLineWidth(arcWidth)
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: fullCircle, clockwise: false)
        context.strokePath()

        if let index = arcColorValues.firstIndex(where: { $0 > value }), let color = arcForegroundColors.element(at: index) {
            context.setStrokeColor(color.cgColor)
        } else {
            context.setStrokeColor(UIColor.clear.cgColor)
        }
        context.setLineWidth(arcWidth)
        context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        context.strokePath()

        valueLabel.text = String(format: "%2.0f", value * 100)
        percentView.isHidden = false
        percentLabel.topConstraint?.constant = valueLabel.font.capAscentHeight - percentLabel.font.capAscentHeight
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsDisplay()
    }

    // Functions

    public func animate(newValue: CGFloat, withDuration duration: TimeInterval, completion: (() -> Void)? = nil) {
        guard duration > 0 else {
            value = newValue
            return
        }
        let frameTime: TimeInterval = 0.033
        var currentDuration: TimeInterval = 0

        let timer = Timer(timeInterval: frameTime, repeats: true) { [self] timer in
            currentDuration += frameTime
            let x = CGFloat(currentDuration / duration)
            value = sqrt((2 - x) * x) * newValue

            if currentDuration >= duration {
                value = newValue
                timer.invalidate()
                completion?()
            }
        }
        self.timer?.invalidate()
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    private func updateFonts() {
        valueLabel.font = Rubik.regular.font(.subheadline, size: fontSize, maximumSize: fontMaxSize)
        percentLabel.font = Rubik.regular.font(.subheadline, size: fontSize/3.0, maximumSize: fontMaxSize/3.0)
    }
}

public extension CirclePercentView {

    func setTMDBStyle() {
        fontSize = 14
        fontMaxSize = 14 * 1.6
        addContentSizeObserver { [unowned self] _ in
            arcWidth = min(UIFontMetrics.default.scaledValue(for: 2), 2 * 1.6)
        }
        arcSpam = 2
        arcColorValues = [0.4, 0.7, 1.01]
        arcBackgroundColors = [Palette.Purple.tyrionPurple, Palette.Yellow.oliveDrab, Palette.Green.britishRacingGreen]
        arcForegroundColors = [Palette.Red.ruby, Palette.Yellow.pear, Palette.Green.emerald]
        cirleColor = Palette.Black.richBlackFOGRA
        arcBackgroundNilColor = Palette.Gray.dimGray
        backgroundColor = .clear
    }
}
