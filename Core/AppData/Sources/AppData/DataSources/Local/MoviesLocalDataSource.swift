//
//  MoviesLocalDataSource.swift
//  AppData
//
//  Created by Jezreel Barbosa on 20/01/22.
//

import Foundation
import Common

public protocol MoviesLocalDataSource {

    func getApiKey() -> String?
}
