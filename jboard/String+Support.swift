//
//  String+support.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/28/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

extension String {
    var camelCase: String {
        let source = self
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(source.startIndex, offsetBy: 1))
            let cammel = source.capitalized.replacingOccurrences(of: " ", with: "")
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(source.startIndex, offsetBy: 1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
            
        }
    }
    
    var snakeCase: String {
        let source = self
        return source.replacingOccurrences(of: "([a-z])([A-Z])",
                                           with: "$1_$2",
                                           options: .regularExpression,
                                           range: nil).lowercased().replacingOccurrences(of: " ", with: "_")
    }
    
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
