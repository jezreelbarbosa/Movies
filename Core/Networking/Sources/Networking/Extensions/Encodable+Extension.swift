//
//  Encodable+Extension.swift
//  Networking
//
//  Created by Jezreel Barbosa on 15/02/22.
//

import Foundation

extension Encodable {

    var parameters: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
