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

class MovieView: UICodeControl, NotificationTokenObserver {

    // Properties

    let posterImageView = UIImageView()
    let percentageView = CirclePercentView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    weak var movie: MovieGridViewModel?

    var notificationTokens: [NotificationToken] = []

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
        posterImageView.fillHorizontally().top(0).aspectRatio(2/3)
        percentageView.size(42).leading(8).CenterY == posterImageView.Bottom
        percentageView.heightConstraint?.scaledConstant(for: .footnote, maxValue: 42 * 1.6)
        percentageView.widthConstraint?.scaledConstant(for: .footnote, maxValue: 42 * 1.6)
        titleLabel.fillHorizontally(padding: 8).Top == percentageView.Bottom + 8
        dateLabel.fillHorizontally(padding: 8).bottom(>=8).Top == titleLabel.Bottom
    }

    public override func initStyle() {
        style { s in
            s.backgroundColor = Colors.backgroundColor
            s.layer.cornerRadius = 8
            s.layer.borderWidth = 1
            s.layer.borderColor = Colors.borderColor.cgColor
        }
        posterImageView.style { s in
            s.backgroundColor = .dynamic(any: .gray, dark: .black)
            s.layer.cornerRadius = 8
            s.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            s.layer.masksToBounds = true
            s.isUserInteractionEnabled = false
        }
        percentageView.style { s in
            s.setTMDBStyle()
            s.isUserInteractionEnabled = false
        }
        titleLabel.style { s in
            s.font = SourceSansPro.bold.font(.headline, maximumSize: 18 * 1.6)
            s.textColor = Colors.labelTitleColor
            s.numberOfLines = 3
            s.isUserInteractionEnabled = false
        }
        dateLabel.style { s in
            s.font = SourceSansPro.light.font(.subheadline, maximumSize: 15 * 1.6)
            s.textColor = Colors.labelDateColor
            s.isUserInteractionEnabled = false
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = Colors.borderColor.cgColor
    }

    // Functions

    @discardableResult
    func fill(movie: MovieGridViewModel) -> Self {
        self.movie = movie
        titleLabel.text = movie.title
        dateLabel.text = movie.date
        percentageView.value = movie.percent
//        percentageView.animate(newValue: movie.percent, withDuration: 1.6)

        let name = MovieGridViewModel.didDownloadPosterImageNN
        addObserver(name: name, object: movie) { [weak self] _ in
            self?.posterImageView.image = self?.movie?.posterImage
        }
        posterImageView.image = movie.posterImage

        return self
    }

    func prepareForReuse() {
        posterImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
        percentageView.value = 0
        notificationTokens.removeAll()
    }
}
