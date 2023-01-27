//
//  MoviesGridNavigationController.swift
//  MoviesGrid
//
//  Created by Jezreel Barbosa on 17/10/21.
//

import Foundation
import UIKit

public class MoviesGridNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = Texts.MoviesGrid.moviesTitle
        tabBarItem.image = Assets.filmIcon.image
        navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) { navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance }
    }
}
