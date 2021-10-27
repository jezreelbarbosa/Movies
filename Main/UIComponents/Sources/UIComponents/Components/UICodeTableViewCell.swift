//
//  UICodeTableViewCell.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 23/10/21.
//

import Foundation
import UIKit

open class UICodeTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
