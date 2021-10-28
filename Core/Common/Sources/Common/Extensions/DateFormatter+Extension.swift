//
//  DateFormatter+Extension.swift
//  Common
//
//  Created by Jezreel Barbosa on 27/10/21.
//

import Foundation

public extension DateFormatter {

    convenience init(_ dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
