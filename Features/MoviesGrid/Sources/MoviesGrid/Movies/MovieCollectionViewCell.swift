//
//  MovieCollectionViewCell.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit
import Stevia
import UIComponents

class MovieCollectionViewCell: UICodeCollectionViewCell {

    // Properties

    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let percentageView = UIView()

    // Lifecycle

    public override func initSubviews() {
        subviews {

        }
    }

    public override func initLayout() {

    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = .black
        }
    }
}
