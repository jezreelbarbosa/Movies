//
//  UICodeCollectionViewCell.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit

open class UICodeCollectionViewCell: UICollectionViewCell {

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
