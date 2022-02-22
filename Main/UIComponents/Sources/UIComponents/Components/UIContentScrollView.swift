//
//  File.swift
//  
//
//  Created by Jezreel Barbosa on 21/11/21.
//

import Foundation
import UIKit

open class UIContentScrollView: UIScrollView {

    public let contentView = UIView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    private func initView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

    @discardableResult
    open func layoutScrollAxis(_ axis: NSLayoutConstraint.Axis, margins: CGFloat = 0) -> Self {
        guard let spv = superview else { return self }

        if axis == .vertical {
            contentView.leadingAnchor.constraint(equalTo: spv.leadingAnchor, constant: margins).isActive = true
            contentView.trailingAnchor.constraint(equalTo: spv.trailingAnchor, constant: margins).isActive = true
        } else {
            contentView.topAnchor.constraint(equalTo: spv.topAnchor, constant: margins).isActive = true
            contentView.bottomAnchor.constraint(equalTo: spv.bottomAnchor, constant: margins).isActive = true
        }
        return self
    }

    @discardableResult
    public func csv(_ subViews: UIView...) -> Self {
        csv(subViews)
    }

    @discardableResult
    public func csv(_ subViews: [UIView]) -> Self {
        for subview in subViews {
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}
