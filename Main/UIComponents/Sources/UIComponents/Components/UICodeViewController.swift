//
//  UICodeViewController.swift
//  UIComponents
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import UIKit

open class UICodeViewController<T, U: UIView>: UIViewController {

    public let presenter: T
    public private(set) lazy var rootView = U()

    public init(presenter: T) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    open override func loadView() {
        view = rootView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPresenter()
    }

    public required init?(coder: NSCoder) {
        fatalError("This class has to be initialized with view code only")
    }

    open func setupView() {}
    open func setupPresenter() {}
}
