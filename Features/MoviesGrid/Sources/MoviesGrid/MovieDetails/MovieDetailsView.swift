//
//  MovieDetailsView.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 21/11/21.
//

import Foundation
import UIKit
import UIComponents
import Stevia

public class MovieDetailsView: UICodeView {

    // Properties

    let backdropImageView = UIImageView()
    let scrollView = UIContentScrollView()

    let titleLabel = UILabel()

    let scoreTrailerStackView = UIStackView()
    let scoreView = UIView()
    let percentageView = CirclePercentView()
    let scoreLabel = UILabel()
    let separatorView = UIView()
    let trailerButton = UIButton()

    let detailsLabel = UILabel()
    let taglineLabel = UILabel()
    let metadataLabel = UILabel()

    // Lifecycle

    public override func initSubviews() {
        subviews(
            scrollView.csv(
                titleLabel,
                scoreTrailerStackView.asv(
                    scoreView.subviews(
                        percentageView,
                        scoreLabel
                    ),
                    separatorView,
                    trailerButton
                ),
                detailsLabel,
                taglineLabel,
                metadataLabel
            ),
            backdropImageView
        )
    }

    public override func initLayout() {
        scrollView.fillSafeArea().layoutScrollAxis(.vertical)

        backdropImageView.fillHorizontally().aspectRatio(16/9).Top == safeAreaLayoutGuide.Top

        titleLabel.fillHorizontally(padding: 16).top(0)
    }

    public override func initStyle() {

    }
}
