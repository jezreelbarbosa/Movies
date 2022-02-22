//
//  AppDataError.swift
//  Domain
//
//  Created by Jezreel Barbosa on 16/02/22.
//

import Foundation

public enum AppDataError: String, Codable, Error {

    case decoderError
    case storageError
    case unknownError
}
