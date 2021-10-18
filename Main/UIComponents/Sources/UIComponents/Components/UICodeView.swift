//
//  UICodeView.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import UIKit

open class UICodeView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        initLayout()
        initStyle()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
        initLayout()
        initStyle()
    }

    open func initSubviews() {}
    open func initLayout() {}
    open func initStyle() {}
}
