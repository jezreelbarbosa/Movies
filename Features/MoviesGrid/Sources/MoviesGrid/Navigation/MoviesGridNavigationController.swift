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
        tabBarItem.title = "Movies"
        if #available(iOS 15.0, *) {
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
    }
}
