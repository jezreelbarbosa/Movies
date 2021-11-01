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
    let loadingView = UIActivityIndicatorView()

    // Lifecycle

    public override func initSubviews() {
        subviews(
            tableView
        )
    }

    public override func initLayout() {
        tableView.fillContainer()
        loadingView.frame = CGRect(origin: .zero, size: CGSize(width: 32, height: 32))
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

    // Functions

    func table(isLoading: Bool) {
        DispatchQueue.main.async { [self] in
            isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
            tableView.tableFooterView = isLoading ? loadingView : nil
            UIView.animate(withDuration: 0.4) {
                tableView.contentOffset.y -= isLoading ? 0 : 16
            }
        }
    }
}
