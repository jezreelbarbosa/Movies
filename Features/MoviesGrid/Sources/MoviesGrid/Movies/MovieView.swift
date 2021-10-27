//
//  MovieView.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 18/10/21.
//

import Foundation
import UIKit
import Stevia
import UIComponents

class MovieView: UICodeView {

    // Properties

    let posterImageView = UIImageView()
    let percentageView = CirclePercentView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    // Lifecycle

    public override func initSubviews() {
        subviews(
            posterImageView,
            percentageView,
            titleLabel,
            dateLabel
        )
    }

    public override func initLayout() {
        posterImageView.fillHorizontally().top(0)
        posterImageView.Height == posterImageView.Width * 1.5
        percentageView.size(42).leading(16).CenterY == posterImageView.Bottom
        percentageView.heightConstraint?.scaledConstant(for: .subheadline, maxValue: 42 * 1.6)
        percentageView.widthConstraint?.scaledConstant(for: .subheadline, maxValue: 42 * 1.6)
        titleLabel.fillHorizontally(padding: 16).Top == percentageView.Bottom + 8
        dateLabel.fillHorizontally(padding: 16).bottom(>=16).Top == titleLabel.Bottom
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Colors.backgroundColor
            s.layer.cornerRadius = 8
            s.layer.borderWidth = 1
            s.layer.borderColor = Colors.borderColor.cgColor
            s.layer.masksToBounds = true
        }
        percentageView.style { s in
            s.setTMDBStyle()
        }
        titleLabel.style { s in
            s.font = SourceSansPro.bold.font(.headline, maximumSize: 18 * 1.6)
            s.textColor = Colors.labelTitleColor
            s.numberOfLines = 3
        }
        dateLabel.style { s in
            s.font = SourceSansPro.light.font(.subheadline, maximumSize: 15 * 1.6)
            s.textColor = Colors.labelDateColor
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = Colors.borderColor.cgColor
    }

    // Functions

    @discardableResult
    func fill(model: MovieGridViewModel) -> Self {
        posterImageView.image = model.image
        posterImageView.backgroundColor = .dynamic(any: .gray, dark: .black)
        titleLabel.text = model.title
        dateLabel.text = model.date
        percentageView.animate(newValue: model.percent, withDuration: 3)
        return self
    }
}
