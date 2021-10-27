//
//  MoviesGridView.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 16/10/21.
//

import Foundation
import UIKit
import UIComponents
import Stevia

public class MoviesGridView: UICodeView {

    // Properties

    let tableView = UITableView()

    // Lifecycle

    public override func initSubviews() {
        subviews(
            tableView
        )
    }

    public override func initLayout() {
        tableView.fillContainer()
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Colors.backgroundColor
        }
        tableView.style { (s) in
            s.backgroundColor = .clear
            s.separatorStyle = .none
            s.contentInset.top = 4
            s.contentInset.bottom = 4
        }
    }
}
